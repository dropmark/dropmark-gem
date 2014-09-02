module Dropmark
  class Model
    include Her::Model
    uses_api Dropmark.api
    
    def to_json(options = {})
      MultiJson.dump(self.attributes, options)
    end
  end
end