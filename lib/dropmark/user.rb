module Dropmark
  class User
    include Her::Model
    uses_api Dropmark.api
    
    attributes :name, :email, :password, :username
    validates :name, presence: true
    validates :email, format: { with: /\A([a-z0-9\+_\-]+)(\.[a-z0-9\+_\-]+)*@([a-z0-9\-]+\.)+[a-z]{2,6}\z/ix }
    validates :password, length: { minimum: 6 }
    validates :username, format: { with: /\A(?!-)([a-z0-9-]{0,49}[a-z0-9])\z/i }
    
    has_many :collections
    custom_get :contacts
    
    def request_path
      if !Dropmark.user_id.nil? and self.try(:id) == Dropmark.user_id
        "users/me"
      else
        super
      end
    end
    
    def self.auth(params)
      if response = self.post('auth', params)
        Dropmark.user_id = response.try(:id)
        Dropmark.user_token = response.try(:token)
      end
      response
    end
  end
end