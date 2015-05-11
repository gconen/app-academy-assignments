require 'addressable/uri'
require 'rest-client'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/123',
  query_values: {
    'top_level' => 'top_level_val',
    'some_category[a_key]' => 'another value',
    'some_category[a_second_key]' => 'yet another value',
    'some_category[inner_inner_hash][key]' => 'value',
    'some_category[inner_inner_hash][key2]' => 'value2',
    'something_else' => 'aaahhhhh'
  }
).to_s

puts RestClient.get(url, :param1 => 'one' )
