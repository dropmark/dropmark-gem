module Dropmark
  class Team < Model
    include Her::Model
    uses_api Dropmark.api
    has_many :collections
    has_many :users
  end
end