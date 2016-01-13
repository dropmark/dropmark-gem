module Dropmark
  class Team < Model
    include Her::Model
    uses_api Dropmark.api
    has_many :collections
    has_many :users
    store_metadata :_metadata # conflicted with actual user metadata

    after_find do |i|
      i.metadata = i._metadata unless i.has_attribute?('metadata')
    end
  end
end