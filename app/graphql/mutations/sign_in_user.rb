require 'jwt'
require "pry"
module Mutations
  class SignInUser < BaseMutation
    null true

    argument :credentials, Types::AuthProviderCredentialsInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(credentials: nil)
      errors = []

      # basic validation
      if credentials.nil?
        errors << "Missing credentials"
      elsif credentials[:email].blank?
        errors << "Email is required"
      elsif credentials[:password].blank?
        errors << "Password is required"
      end
      
      user = User.find_by email: credentials[:email]
      
      # ensures we have the correct user
      if user.nil?
        errors << "Email not found"
      end
      
      if errors.empty?
        
        # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
        # crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        # token = crypt.encrypt_and_sign("user-id:#{ user.id }")
        
        secret_key= Rails.application.credentials.secret_key_base
        algorithm = 'HS256'
        payload = { user_id: user.id, iat: Time.current.to_i, exp: 3.days.from_now.to_i }
        token = JWT.encode(payload, secret_key, algorithm)
        
        context[:session][:token] = token
        { user: user, token: token, errors: [] }
        # binding.pry
      else
        { user: nil, token: nil, errors: errors }
      end
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    rescue JWT::DecodeError => e
      { user: nil, token: nil, errors: ["Invalid token"] }
    end
  end
end