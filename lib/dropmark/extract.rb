module Dropmark
  class Extract < Model
    include Her::Model
    uses_api Dropmark.api

    collection_path "extract"
    resource_path "extract"

    def self.get(params)
      super('extract', params)
    end
  end
end