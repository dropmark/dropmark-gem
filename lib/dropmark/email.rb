module Dropmark
  class Email < Model
    include Her::Model
    uses_api Dropmark.api
    
    collection_path "users/:user_id/emails"
    resource_path "users/:user_id/emails/:id"
    
    validates :email, format: { with: /\A([a-z0-9\+_\-]+)(\.[a-z0-9\+_\-]+)*@([a-z0-9\-]+\.)+[a-z]{2,6}\z/ix }
    
    belongs_to :user
  end
end