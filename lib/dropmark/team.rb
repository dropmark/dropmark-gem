module Dropmark
  class Team < Model
    include Her::Model
    uses_api Dropmark.api
  end
end