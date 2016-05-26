module Dropmark
  class Reaction < Model
    include Her::Model
    uses_api Dropmark.api

    collection_path "items/:item_id/reactions"
    resource_path "reactions/:id"

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