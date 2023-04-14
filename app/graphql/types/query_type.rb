require "pry"
module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :users, [Types::UserType], null: false
    field :payments, [Types::PaymentType], null: false
    field :services, [Types::ServiceType], null: false
    field :billings, [Types::BillingType], null: false
    field :bookings, [Types::BookingType], null: false
    field :cart_items, [Types::CartItemType], null: false
    field :carts, [Types::CartType], null: false

    def users
      User.all
    end

    def payments
      Payment.all
    end

    def services
      Service.all.includes(:category, :rich_text_description, image_attachment: :blob)
    end

    def billings
      Billing.all
    end

    def bookings
      Booking.all
    end

    def cart_items
      CartItem.where(user: context[:current_user])
    end

    def carts
      Cart.all
    end

    # Get service by id/slug
    field :service, ServiceType, null: false do 
      argument :id, ID, required: true
    end
    
    def service(id:)
      Service.find(id)
    end

    # Get current_user booking record
    field :booking, BookingType, null: false do 
      argument :id, ID, required: true
    end
    
    def booking(id:)
      Booking.where(user_id: id).last
    end
  end
end
