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
    if options.key?(:public_key)
      self.public_key = options[:public_key]
    end
  end

  def private_key
    @private_key ||= load_key(:private)
  end

  def private_key=(key = nil)
    @private_key = load_key(:private, key)
  end

  def public_key
    @public_key ||= load_key(:public)
  end

  def public_key=(key = nil)
    @public_key = load_key(:public, key)
  end

  def cert_type
    @cert_type ||= self.class.default_cert_type
  end

  def cert_size
    @cert_size ||= self.class.default_cert_size
  end

private
  def load_key(type, key = nil)
    key = case key
      when String
        cert_type.new(key)
      when nil
        if type == :private
          cert_type.new(cert_size)
        else
          private_key.public_key
        end
      else
        if key.respond_to?(:read)
          load_key(type, key.read)
        end
    end
    if !key || !key.send("#{type}?")
      raise KeyTypeError, "#{type} key should be a valid PKey, String, IO stream, or nil: #{key.inspect}"
    else
      key
    end
  end
end