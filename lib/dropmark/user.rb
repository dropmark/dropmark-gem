module Dropmark
  class User < Model
    include Her::Model
    uses_api Dropmark.api

    validates :name, presence: true
    validates :email, format: { with: /\A([a-z0-9\+_\-]+)(\.[a-z0-9\+_\-]+)*@([a-z0-9\-]+\.)+[a-z]{2,63}\z/ix }
    validates :password, length: { minimum: 6 }
    validates :username, format: { with: /\A(?!-)([a-z0-9-]{0,49}[a-z0-9])\z/i }

    has_many :highlighted_collections, class_name: "Collection"
    has_many :collections
    has_many :tags
    has_many :teams
    has_many :emails

    custom_get :contacts
    store_metadata :_metadata # conflicted with actual user metadata

    after_find do |response|
      process_response(response)
    end

    def request_path
      if !Dropmark.user_id.nil? and self.try(:id) == Dropmark.user_id
        "users/me"
      else
        super
      end
    end

    def self.find_where(params)
      if response = self.get('users', params)
        process_response(response)
      end

      response
    end

    def self.auth(params)
      if response = self.post('auth', params)
        Dropmark.user_id = response.try(:id)
        Dropmark.user_token = response.try(:token)
      end
      response
    end

    private
      def self.process_response(response)
        response.metadata = response._metadata unless response.has_attribute?('metadata')

        begin
          response.created_at = Time.parse(response.created_at)
          response.updated_at = Time.parse(response.updated_at)
        rescue
        end

        response
      end
  end
end