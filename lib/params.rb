require 'uri'

module RailsLite
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      query_params = parse_www_encoded_form(req.query_string)
      body_params = parse_www_encoded_form(req.body)
      @params = hash_deep_merge(query_params, body_params)
      @params = hash_deep_merge(@params, route_params)
    end

    def [](key)
      key = key.to_s
      @params[key]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private

    def hash_deep_merge(first, second)
      unless first.is_a?(Hash) && second.is_a?(Hash)
        raise ArgumentError.new("Can only deep merge two hashes")
      end
      first.merge(second) do |key, first_val, second_val|
        if first_val.is_a?(Hash) && second_val.is_a?(Hash)
          hash_deep_merge(first_val, second_val)
        elsif first_val.is_a?(Array) && second_val.is_a?(Array)
          first_val + second_val
        else
          second_val
        end
      end
    end

    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      www_encoded_form ||= ""
      key_values = URI.decode_www_form(www_encoded_form)
      parsed_form = {}
      key_values.each do |(key, value)|
        nested_keys = parse_key(key)
        nested_hash = create_nested_hash(nested_keys, value)
        parsed_form = hash_deep_merge(parsed_form, nested_hash)
      end

      parsed_form
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/[\[\]]{1,2}/)
    end

    def create_nested_hash(keys_arr, value)
      return value if keys_arr.empty?
      top_key = keys_arr.shift

      { top_key => create_nested_hash(keys_arr, value) }
    end
  end
end
