module Dropmark
  class Collection < Model
    include Her::Model
    uses_api Dropmark.api

    belongs_to :user
    has_many :users
    has_many :items
    custom_get :count
    
    accepts_nested_attributes_for :users

    after_find do |i|
      begin
        i.created_at = Time.parse(i.created_at)
        i.updated_at = Time.parse(i.updated_at)
        i.last_accessed_at = Time.parse(i.last_accessed_at)
      rescue
      end
    end

    def self.sort(order)
      items = put("collections", :order => order)
    end

    def sort_items(order)
      items = Dropmark::Item.put("collections/#{id}/items", :order => order)
    end
  end
end