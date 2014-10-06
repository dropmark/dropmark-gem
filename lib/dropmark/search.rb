module Dropmark
  class Search < Model
    include Her::Model
    uses_api Dropmark.api

    collection_path "search"
    resource_path "search"

    has_many :items
    has_many :collections
    
    def self.by_q(q)
      self.get('search', q: q)
    end
  end
end