libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'her'
require 'ostruct'
require 'rbconfig'
require 'dropmark/version'
require 'dropmark/authentication'
require 'dropmark/error'
require 'dropmark/file'

module Dropmark

  class << self
    attr_accessor :api_key, :api_base, :user_id, :user_token
  end

  def self.api
    @api
  end

  def self.configure(&blk)
    options = OpenStruct.new
    yield(options)

    @api_key = options.try(:api_key)
    @api_base = options.try(:api_base) || 'https://api.dropmark.com/v1'
    @user_id = options.try(:user_id)
    @user_token = options.try(:user_token)

    @api = Her::API.new
    @api.setup :url => @api_base do |c|
      c.use Faraday::Response::Logger
      c.use Dropmark::Authentication
      c.use Faraday::Request::Multipart
      c.use Faraday::Request::UrlEncoded
      c.use Her::Middleware::DefaultParseJSON
      c.use Faraday::Adapter::NetHttp
      c.use Dropmark::Error::RaiseError
    end
    require 'dropmark/model'
    require 'dropmark/collection'
    require 'dropmark/comment'
    require 'dropmark/tag'
    require 'dropmark/item'
    require 'dropmark/user'
  end

end

