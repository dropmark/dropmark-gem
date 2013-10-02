module Dropmark
  class Collection
    include Her::Model
    uses_api Dropmark.api
    
    has_many :users
    has_many :items
    custom_get :count
    
    def self.sort(order)
      items = put("collections", :order => order)
    end
    
    def sort_items(order)
      items = Dropmark::Item.put("collections/#{id}/items", :order => order)
    end
  end
end