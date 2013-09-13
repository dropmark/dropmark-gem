require 'base64'

module Dropmark
  class Authentication < Faraday::Middleware
  
    def initialize(app, options={})
      @app = app
      @options = options
    end
    
    def call(env)
      if Dropmark.user_id
        basic_auth = Base64.encode64([Dropmark.user_id, Dropmark.user_token].join(':')).to_s.gsub!("\n", '')
        env[:request_headers]["Authorization"] = "Basic #{basic_auth}"
      end
      env[:request_headers]["X-API-Key"] = Dropmark.api_key
      @app.call(env)
    end
    
  end
end