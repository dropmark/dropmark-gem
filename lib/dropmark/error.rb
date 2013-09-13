module Dropmark
  module Error
    class BadRequest < StandardError; end
    class Forbidden < StandardError; end
    class NotFound < StandardError; end
    class ServerError < StandardError; end

    class RaiseError < Faraday::Response::Middleware
      def parse(body)
        if body = MultiJson.load(body, :symbolize_keys => true)
          body[:message] if body.has_key?(:message)
        end
      end
      
      def on_complete(env)
        return if (status = env[:status]) < 400 # Ignore any non-error response codes
        
        message = parse(env[:body])
        case status
        when 400
          raise Dropmark::Error::BadRequest, message
        when 403
          raise Dropmark::Error::Forbidden, message
        when 404
          raise Dropmark::Error::NotFound, message
        else
          raise Dropmark::Error::ServerError, message # Treat any other errors as 500
        end
      end
    end
  end
end