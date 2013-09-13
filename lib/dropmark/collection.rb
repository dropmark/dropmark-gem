module Dropmark
  class Collection
    include Her::Model
    uses_api Dropmark.api
    
    has_many :users
    has_many :items
    custom_get :count
  end
end