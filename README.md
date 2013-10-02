Dropmark Gem
============

- [Installation](#installation)
- [Using this gem in your application](#using-this-gem-in-your-application)
- [Using the API](#using-the-api)
- [Contributing](#contributing)

Installation
------------

The Dropmark gem is available for installation on [Rubygems](https://rubygems.org/gems/dropmark). To install run:

    gem install dropmark # todo


Using this gem in your application
----------------------------------
    
To use this gem in your application, add the following to your Gemfile:

    gem 'dropmark', :git => 'git://github.com/dropmark/dropmark-gem.git'


Using the API
-------------

This gem allows you to interact with the Dropmark API.

```ruby
require 'dropmark'

# authenticate application
Dropmark.configure do |config|
  config.api_key    = 'API_KEY'
  config.api_base   = 'https://api.dropmark.com/v1'  # optional
  config.user_id    = 'USER_ID'                      # optional, see below to retrieve
  config.user_token = 'USER_TOKEN'                   # optional, see below to retrieve
end

# retreive user token if needed
user = Dropmark::User.auth(email: 'EMAIL', password: 'PASSWORD')
# note: store user.id and user.token for future use, never store password

# get authenticated user
user = Dropmark::User.find('me')

# get first 20 collections for authenticated user
collections = Dropmark::Collection.all(page: 1, count: 20)

# get collection by id
collection = Dropmark::Collection.find(133727)

# create new collection for authenticated user
collection = Dropmark::Collection.create(
  name:          'New collection',
  type:          'private',          # optional ('private', 'public', 'global')
  sort_by:       'created_at',       # optional ('name', 'created_at', 'updated_at')
  sort_order:    'desc',             # optional ('asc', 'desc')
  thumbnails:    'square',           # optional ('square', 'full')
  labels:        'true',             # optional ('true', 'false')
)

# delete collection
collection.destroy
# or delete collection by id
Dropmark::Collection.destroy_existing(133727)

# sort collections by ids
collections = Dropmark::Collection.sort([101, 102, 103])

# get items in collection
items = collection.items
# or get items without fetching collection
items = Dropmark::Item.where(collection_id: 133727)

# get item by id
item = Dropmark::Item.find(2139403)

# sort items in collection by item ids
items = collection.sort_items([101, 102, 103])
# or sort items without fetching collection
items = Dropmark::Item.sort(collection_id, [101, 102, 103])

# create new item
item = collection.items.create(content: 'http://dropmark.com')
# or
item = Dropmark::Item.create(
  collection_id: 133727,
  name:          'Logo',                                         # optional
  content:       'http://dropmark.com/assets/images/logo.png',   # required (URL, file, or text)
  description:   'Dropmark logo',                                # optional
  link:          'http://dropmark.com',                          # optional
  thumbnail:     'http://dropmark.com/assets/images/logo.png',   # optional
  shareable:     'true'                                          # optional
)

# upload file item
item = Dropmark::Item.create(
  collection_id: 133727,
  content:       Dropmark::File.new('~/photo.jpg')
)

# update item
item.name = 'My Photo'
item.save
# or update by id
item = Dropmark::Item.save_existing(2316519, name: 'My Photo')

# delete item
item.destroy
# or delete by id
Dropmark::Item.destroy_existing(2139403)

# get item comments
comments = item.comments.all

# add comment
comment = item.comments.create(body: 'My comment')
# or comment by item id
comment = Dropmark::Comment.create(item_id: 2316545, body: 'My comment')

# delete comment
comment.destroy
# or comment by id
Dropmark::Comment.destroy_existing(2139403)
```


Contributing
------------

Help us improve this gem:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
