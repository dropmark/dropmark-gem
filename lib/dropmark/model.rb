module Dropmark
  class Model
    include Her::Model
    uses_api Dropmark.api
    
    def to_json
      MultiJson.dump(self.attributes)
    end
  end
end