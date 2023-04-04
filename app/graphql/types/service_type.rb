# frozen_string_literal: true

module Types
  class ServiceType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :price, Integer
    field :description, String
    field :image, String, null: false
    field :available_date, GraphQL::Types::ISO8601Date
    field :slug, String
    field :available_slots, GraphQL::Types::JSON
    field :category, CategoryType, null: true, method: :category
    field :listed_by, UserType, null: true, method: :user
    
    def image
      Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true)
    end
  end
end
