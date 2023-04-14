module Mutations
  class CreateBook < Mutations::BaseMutation
    argument :booked_time, String, required: true
    argument :slot, Integer, required: true
    argument :service_id, ID, required: true
    argument :payment_id, ID, required: true
    argument :billing_id, ID, required: true

    field :booking, Types::BookingType, null: false
    field :errors, [String], null: false

    def resolve(booked_time: nil, slot: nil, service_id: nil, payment_id: nil, billing_id: nil)
      errors = []
      
      user = context[:current_user]
      puts "User #{user}"

      unless user
        errors << "User must be authenticated to book"
        return { booking: [], errors: errors }
      end
      
      if user # Assuming you are using Devise or a similar authentication gem
        @cart ||= user.cart || Cart.create(user: current_user) # Associate cart with the logged-in user
      else
        @cart ||= Cart.find_by(id: session[:cart_id]) # Fallback to session-based cart for guests
      end
    
      if @cart.nil?
        @cart = Cart.create
        session[:cart_id] = @cart.id unless user_signed_in? # Store cart_id in session only for guests
      end


      booking = user.bookings.build(
        booked_time: booked_time, 
        slot: slot, 
        service_id: service_id, 
        payment_id: payment_id, 
        billing_id: billing_id 
      )

      if booking.save 
        receipt = Receipt.new(user: user, booking_id: booking.id)
        receipt.save
        ReceiptMailer.send_receipt(user, receipt).deliver_now
        @cart.cart_items.where(user: user).delete_all
        
        { booking: booking, errors: [] }
      else
        { booking: nil, errors: booking.errors.full_messages }
      end
    end

    def current_user 
    secret_key = Rails.application.credentials.secret_key_base
    puts "Secret key: #{secret_key}"
    token = get_bearer_token
    puts "current user token from headers: #{toke}"
    return nil unless token.present?

    begin
      secret_key = Rails.application.credentials.secret_key_base
      decoded_token = JWT.decode(token, secret_key, true, algorithm: "HS256")
      user_id = decoded_token.first["user_id"]
      User.find_by(id: user_id)
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
      nil
    end
    end

    def get_bearer_token
      bearer = context[:request].headers['Authorization'] || context[:request].headers['authorization']
      if bearer.present?
        token = bearer.gsub('Bearer ', '').strip
        token = token.undump
        puts "Token from headers: #{token}"
        token
      else 
        nil
      end
    end
  end
end