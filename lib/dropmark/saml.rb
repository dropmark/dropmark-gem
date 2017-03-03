module Dropmark
  class Saml < Model
    include Her::Model
    uses_api Dropmark.api

    def self.get(params = {})
      get_raw('auth/saml', params) do |parsed_data, response|
        parsed_data[:data]
      end
    end

    def self.post(params)
      post_raw('auth/saml', params) do |parsed_data, response|
        parsed_data[:data]
      end
    end
  end
end
