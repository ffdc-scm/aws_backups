$LOAD_PATH.unshift("lib")
require 'backup'
require 'right_aws'
require 'logger'
require 'yaml'
require 'rspec/mocks'

#RSpec.configure do |config|
#  config.mock_with :rspec do |mocks|
#
#    # This option should be set when all dependencies are being loaded
#    # before a spec run, as is the case in a typical spec helper. It will
#    # cause any verifying double instantiation for a class that does not
#    # exist to raise, protecting against incorrectly spelt names.
#    mocks.verify_doubled_constant_names = true
#
#  end
#end
