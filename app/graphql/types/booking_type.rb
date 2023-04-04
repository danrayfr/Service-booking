# frozen_string_literal: true

module Types
  class BookingType < Types::BaseObject
    field :id, ID, null: false
    field :status, String
    field :booked_time, String
    field :slot, Integer
    field :service, ServiceType, null: false, method: :service
    field :payment, PaymentType, null: false, method: :payment
    field :billing, BillingType, null: false, method: :billing
    field :booked_by, UserType, null: false, method: :user
  end
end
