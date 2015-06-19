module Dropmark
  class Item < Model
    include Her::Model
    uses_api Dropmark.api

    collection_path "collections/:collection_id/items"
    resource_path "items/:id"

    belongs_to :collection
    has_many :comments
    has_many :items
    has_one :user
    has_one :parent, class_name: "Item"
    has_one :prev, class_name: "Item"
    has_one :next, class_name: "Item"
    custom_get :count

    method_for :update, :post

    # Commented-out because of https://github.com/dropmark/dropmark-gem/issues/11
    # store_metadata :_metadata # conflicted with actual item metadata

    after_initialize do |i|
      # Commented-out because of https://github.com/dropmark/dropmark-gem/issues/11
      # i.metadata = i._metadata unless i.has_attribute?('metadata')
      begin
        i.created_at = Time.parse(i.created_at)
        i.updated_at = Time.parse(i.updated_at)
      rescue
      end
    end

    # Dropmark can return multiple items in a single create
    def self.create(attributes)
      items = self.post("collections/#{attributes['collection_id']}/items", attributes)
    end

    def self.sort(id, order)
      items = Dropmark::Collection.new(:id => id).sort_items(order)
    end
  end
end