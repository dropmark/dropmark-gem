module Dropmark
  class Tag < Model
    include Her::Model
    uses_api Dropmark.api
    has_many :items
  end
end