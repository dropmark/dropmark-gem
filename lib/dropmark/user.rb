module Dropmark
  class User
    include Her::Model
    uses_api Dropmark.api
    
    has_many :collections
    custom_get :contacts
    
    def request_path
      if self.try(:id) == Dropmark.user_id
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