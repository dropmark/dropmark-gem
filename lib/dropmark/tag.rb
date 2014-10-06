module Dropmark
  class Tag < Model
    include Her::Model
    uses_api Dropmark.api
    has_many :items
    
    def self.get(params)
      super('tags', params)
    end
  end
end