require 'test_helper'

$private_key = "-----BEGIN RSA PRIVATE KEY-----\nMIIBOQIBAAJBAOLftrUhAdZpodQ8OczSgcudLAogxjuh5834rHD7bAs51UTSCoAQ\nOPHaadlTPd+1XEogvTqIP7KYZL5w83RbH58CAwEAAQJANcrbdFjuKZuELmFVRxZG\nhjOvBHu+5Na/spuar3M9q+9JIXAMmenFQbQkedR+utpvUUGxacCFCIWxuqmzeEKc\nUQIhAPnMyvb0tRePVbfFjc2kXkN7Yr2bmZ5SVAD9h84NDjnHAiEA6IFAIKRw11s2\npvDYbKrjNhJapSriuQQ6RSNB6NOnK2kCIHERIU1mthFT75ie8vCB1aj10FvCcmYX\nHa7VEwNRJX9BAiB0xpYCzxSt1W45orXQvnOn8Mf+NO/ypSDvIKo12jgYIQIgcSfd\nlw7dCdeaJraI98Sh6bhZUVvo2z9Yyel6lpMLZN0=\n-----END RSA PRIVATE KEY-----\n"
$public_key  = "-----BEGIN RSA PUBLIC KEY-----\nMEgCQQDi37a1IQHWaaHUPDnM0oHLnSwKIMY7oefN+Kxw+2wLOdVE0gqAEDjx2mnZ\nUz3ftVxKIL06iD+ymGS+cPN0Wx+fAgMBAAE=\n-----END RSA PUBLIC KEY-----\n"

class PkiTest < Test::Unit::TestCase
  def test_creates_random_private_key
    pki = Pki.new
    assert_not_nil pki.private_key
    assert pki.private_key.private?
  end

  def test_initializes_with_private_key_string
    pki = Pki.new :private_key => $private_key
    assert pki.private_key.private?
    assert_equal $private_key, pki.private_key.to_s
  end

  def test_sets_private_key_string
    pki = Pki.new
    pki.private_key = $private_key
    assert pki.private_key.private?
    assert_equal $private_key, pki.private_key.to_s
  end

  def test_sets_private_key_stream
    pki = Pki.new
    io  = StringIO.new($private_key)
    pki.private_key = io
    assert pki.private_key.private?
    assert_equal $private_key, pki.private_key.to_s
  end

  def test_creates_random_public_key
    pki = Pki.new
    assert_not_nil pki.public_key
    assert pki.public_key.public?
  end

  def test_initializes_with_public_key_string
    pki = Pki.new :public_key => $public_key
    assert pki.public_key.public?
    assert_equal $public_key, pki.public_key.to_s
  end

  def test_sets_public_key_string
    pki = Pki.new
    pki.public_key = $public_key
    assert pki.public_key.public?
    assert_equal $public_key, pki.public_key.to_s
  end

  def test_sets_public_key_stream
    pki = Pki.new
    io  = StringIO.new($public_key)
    pki.public_key = io
    assert pki.public_key.public?
    assert_equal $public_key, pki.public_key.to_s
  end

  def test_raises_error_on_setting_public_key_to_private_key
    assert_raises Pki::KeyTypeError do
      Pki.new :private_key => $public_key
    end
  end
end
