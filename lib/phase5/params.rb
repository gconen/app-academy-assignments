require 'uri'

module Phase5
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
      @params = query_params.deep_merge(body_params)
      @params = @params.deep_merge(route_params)
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
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      www_encoded_form ||= ""
      key_values = URI.decode_www_form(www_encoded_form)
      hash = {}
      key_values.each do |(key, value)|
        nested_keys = parse_key(key)
        nested_hash = create_nested_hash(nested_keys, value)
        hash = hash.deep_merge(nested_hash)
      end

      hash
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

  class Hash
    def deep_merge(other)
      unless other.is_a?(Hash)
        raise ArgumentError.new("Can only deep_merge hashes with other hashes")
      end
      self.merge(other) do |key, self_val, other_val|
        if self_val.is_a?(Hash) && other_val.is_a?(Hash)
          self_val.deep_merge(other_val)
        elsif self_val.is_a?(Array) && other_val.is_a?(Array)
          self_val + other_val
        else
          other_val
        end
      end
    end
  end
end
