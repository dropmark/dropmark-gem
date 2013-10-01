module Dropmark
  class Collection
    include Her::Model
    uses_api Dropmark.api
    
    has_many :users
    has_many :items
    custom_get :count
    
    def sort_items(order)
      items = Dropmark::Item.put("collections/#{id}/items", order: order)
    end
  end
end