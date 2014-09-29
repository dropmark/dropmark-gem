module Dropmark
  class Tag < Model
    include Her::Model
    uses_api Dropmark.api

    belongs_to :item

    after_find do |i|
      begin
        i.created_at = Time.parse(i.created_at)
        # i.updated_at = Time.parse(i.updated_at)
      rescue
      end
    end
  end
end