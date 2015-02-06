module Dropmark
  class Parser < Her::Middleware::ParseJSON

    def parse(body, headers = {})
      json = parse_json(body)
      errors = json.delete(:errors) || {}
      metadata = json.delete(:metadata) || {}
      metadata[:total_count] = headers['x-total-count'].try(:to_i) if headers['x-total-count']

      {
        :data => json,
        :errors => errors,
        :metadata => metadata
      }
    end

    def on_complete(env)
      env[:body] = case env[:status]
      when 204
        parse('{}', env[:response_headers])
      else
        parse(env[:body], env[:response_headers])
      end
    end
  end
end