module Dropmark
  class Search < Model
    include Her::Model
    uses_api Dropmark.api

    collection_path "search"
    resource_path "search"

    has_many :items
    has_many :collections
  end
end