# frozen_string_literal: true

module Types
  class CategoryType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :slug, String
    field :image, String, null: false

    def image
      Rails.application.routes.url_helpers.rails_blob_url(object.image, only_path: true)
    end
  end
end
