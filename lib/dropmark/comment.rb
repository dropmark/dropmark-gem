module Dropmark
  class Comment
    include Her::Model
    uses_api Dropmark.api
    
    collection_path "items/:item_id/comments"
    resource_path "comments/:id"
    
    belongs_to :item
  end
end