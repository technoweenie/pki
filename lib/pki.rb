require 'openssl'
class Pki
  class KeyTypeError < StandardError; end

  class << self
    attr_accessor :default_cert_type
    attr_accessor :default_cert_size
  end

  self.default_cert_type = OpenSSL::PKey::RSA
  self.default_cert_size = 512

  def initialize(options = {})
    @private_key = @public_key = nil
  end

  def private_key(key = nil)
    @private_key ||= load_private_key(key)
  end

private
  def load_private_key(key = nil)
    self.class.default_cert_type.new(self.class.default_cert_size)
  end
end