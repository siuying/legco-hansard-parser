$LOAD_PATH << "lib"
require 'legco'
require 'vcr'
require 'pry'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :new_episodes }
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end

def test_doc(filename="fixtures/sample.txt")
  data = open(File.join(File.dirname(__FILE__), filename)).read
  doc = Legco::Hansard::Document.new(data)
  cleanup = Legco::Hansard::Filters::CleanupFilter.new
  cleanup.process doc
  doc
end