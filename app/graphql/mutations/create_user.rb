module Mutations
  class CreateUser < Mutations::BaseMutation

    class AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
    end

    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :mobile, String, required: true
    argument :auth_provider, AuthProviderSignupData, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(first_name: nil, last_name:nil, mobile: nil, auth_provider: nil)
      user = User.new(
        name: first_name,
        last_name: first_name,
        mobile: mobile,
        email: auth_provider&.[](:credentials)&.[](:email),
        password: auth_provider&.[](:credentials)&.[](:password),
        password_confirmation: auth_provider&.[](:credentials)&.[](:password_confirmation)
      )

      if user.save
        { user: user, errors: [], }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end

  end
end
