require 'openssl'
class Pki
  class KeyTypeError < StandardError; end

  class << self
    attr_accessor :default_cert_type
    attr_accessor :default_cert_size
  end

  attr_writer :cert_type
  attr_writer :cert_size

  self.default_cert_type = OpenSSL::PKey::RSA
  self.default_cert_size = 512

  def initialize(options = {})
    @private_key = @public_key = @cert_key = @cert_size = nil
    if options.key?(:private_key)
      self.private_key = options[:private_key]
    end
  end

  def private_key
    @private_key ||= load_key(:private)
  end

  def private_key=(key = nil)
    @private_key = load_key(:private, key)
  end

  def cert_type
    @cert_type ||= self.class.default_cert_type
  end

  def cert_size
    @cert_size ||= self.class.default_cert_size
  end

private
  def load_key(type, key = nil)
    case key
      when String
        cert_type.new(key)
      when nil
        cert_type.new(cert_size)
      else
        if key.respond_to?(:read)
          load_key(type, key.read)
        else
          raise ArgumentError, "key should be a PKey, String, IO stream, or nil: #{key.inspect}"
        end
    end
  end
end