module Dropmark
  class Comment < Model
    
    collection_path "items/:item_id/comments"
    resource_path "comments/:id"
    
    belongs_to :item
    
    after_find do |i|
      begin
        i.created_at = Time.parse(i.created_at)
        i.updated_at = Time.parse(i.updated_at)
      rescue
      end
    end
  end
end