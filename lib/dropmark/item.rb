module Dropmark
  class Item
    include Her::Model
    uses_api Dropmark.api
    
    collection_path "collections/:collection_id/items"
    resource_path "items/:id"
    
    belongs_to :collection
    has_many :comments
    custom_get :count
    
    store_metadata :_metadata # conflicted with actual item metadata
    
    after_find do |i|
      begin
        i.created_at = Time.parse(i.created_at)
        i.updated_at = Time.parse(i.updated_at)
      rescue
      end
    end
    
    def self.sort(id, order)
      items = Dropmark::Collection.new(:id => id).sort_items(order)
    end
  end
end