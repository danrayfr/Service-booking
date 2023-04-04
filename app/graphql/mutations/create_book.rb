require "pry"
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

      
      unless user
        errors << "User must be authenticated to book"
        return { booking: [], errors: errors }
      end
      
      binding.pry
      
      booking = user.bookings.build(
        booked_time: booked_time, 
        slot: slot, 
        service_id: service_id, 
        payment_id: payment_id, 
        billing_id: billing_id 
      )

      if booking.save 
        { booking: booking, errors: [] }
      else
        { booking: nil, errors: booking.errors.full_messages }
      end
    end
  end
end