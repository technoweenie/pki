require 'rubygems'
require 'test/unit'
require 'stringio'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'pki'

begin
  require 'ruby-debug'
  Debugger.start
rescue LoadError
end

class Test::Unit::TestCase
end
