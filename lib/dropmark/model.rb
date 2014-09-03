module Dropmark
  class Model
    def to_json(options = {})
      MultiJson.dump(self.attributes, options)
    end
  end
end