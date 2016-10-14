module Dropmark
  class Item < Model
    include Her::Model
    uses_api Dropmark.api

    collection_path "items"
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

    store_metadata :_metadata # conflicted with actual item metadata

    after_initialize do |i|
      i.metadata = i._metadata unless i.has_attribute?('metadata')
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

    def self.copy(attributes)
      items = self.post("items/copy", attributes)
    end

    def self.sort(id, order)
      items = Dropmark::Collection.new(:id => id).sort_items(order)
    end

    def self.add_tag(attributes)
      self.post("items/#{attributes['id']}/tags", attributes)
    end
  end
end