module Dropmark
  class Upload < Model
    include Her::Model
    uses_api Dropmark.api

    resource_path "uploads"
  end
end