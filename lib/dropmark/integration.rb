module Dropmark
  class Integration < Model
    include Her::Model
    uses_api Dropmark.api
    belongs_to :collection
    belongs_to :user
  end
end