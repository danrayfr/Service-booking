# frozen_string_literal: true

module Types
  class BookingType < Types::BaseObject
    field :id, ID, null: false
    field :status, String
    field :booked_time, String
    field :slot, Integer
    field :user, Types::UserType, null: false
    field :service, ServiceType, null: false
    field :payment, PaymentType, null: false
    field :billing, BillingType, null: false
  end
end
