module Dropmark
  class Search < Model
    include Her::Model
    uses_api Dropmark.api

    def self.new(params = {})
      case params[:type]
      when 'collection'
        return Collection.new(params)
      when 'comment'
        return Comment.new(params)
      else
        return Item.new(params)
      end
    end
    
    def self.get(params)
      super('search', params)
    end
  end
end