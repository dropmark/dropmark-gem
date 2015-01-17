module Dropmark
  class Email < Model
    include Her::Model
    uses_api Dropmark.api
    
    validates :email, format: { with: /\A([a-z0-9\+_\-]+)(\.[a-z0-9\+_\-]+)*@([a-z0-9\-]+\.)+[a-z]{2,63}\z/ix }
    
    belongs_to :user
  end
end