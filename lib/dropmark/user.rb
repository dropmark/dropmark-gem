module Dropmark
  class User < Model
    include Her::Model
    uses_api Dropmark.api

    attributes :name, :email, :password, :username
    validates :name, presence: true
    validates :email, format: { with: /\A([a-z0-9\+_\-]+)(\.[a-z0-9\+_\-]+)*@([a-z0-9\-]+\.)+[a-z]{2,6}\z/ix }
    validates :password, length: { minimum: 6 }
    validates :username, format: { with: /\A(?!-)([a-z0-9-]{0,49}[a-z0-9])\z/i }

    has_many :collections
    has_many :tags
    has_many :teams
    custom_get :contacts

    after_find do |i|
      begin
        i.created_at = Time.parse(i.created_at)
        i.updated_at = Time.parse(i.updated_at)
      rescue
      end
    end

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