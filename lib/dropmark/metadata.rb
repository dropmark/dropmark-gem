module Dropmark
  class Metadata < Model
    include Her::Model
    uses_api Dropmark.api

    def self.get(params)
      super(::File.join('metadata', params[:group]), params)
    end
  end
end
