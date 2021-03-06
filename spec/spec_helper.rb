require 'simplecov'

SimpleCov.start 'rails' do
  SimpleCov.minimum_coverage 80
  SimpleCov.maximum_coverage_drop 2
  add_filter ['vendor', /application_/]
end

RSpec.configure do |config|
  Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}
  
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
 
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
