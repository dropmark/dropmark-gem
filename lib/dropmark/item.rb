module Dropmark
  class Item < Model
    
    collection_path "collections/:collection_id/items"
    resource_path "items/:id"
    
    belongs_to :collection
    has_many :comments
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
    
    def self.sort(id, order)
      items = Dropmark::Collection.new(:id => id).sort_items(order)
    end
  end
end