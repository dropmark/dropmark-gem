module Dropmark
  class Expand < Model
    include Her::Model
    uses_api Dropmark.api

    collection_path "expand"
    resource_path "expand"
    
    def self.get(params)
      super('expand', params)
    end
  end
end