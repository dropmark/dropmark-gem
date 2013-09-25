require 'mime/types'

module Dropmark
  class File < Faraday::UploadIO
    def initialize(file, mime = nil, filename = nil)
      if mime.nil? and detected_mimes = MIME::Types.type_for(file)
        mime = detected_mimes.first
      end
      super(file, mime.to_s, filename)
    end
  end
end