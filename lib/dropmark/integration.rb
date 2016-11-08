module Dropmark
  class Integration < Model
    include Her::Model
    uses_api Dropmark.api
    belongs_to :collection
    belongs_to :user

    store_metadata :_metadata # conflicted with actual integration metadata

    after_initialize do |i|
      i.metadata = i._metadata unless i.has_attribute?('metadata')
    end
  end
end