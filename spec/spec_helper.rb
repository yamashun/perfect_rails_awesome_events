ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)


require 'rspec/rails'
require 'factory_girl_rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|


  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  # config.mock_with :rspec do |mocks|
  #   # Prevents you from mocking or stubbing a method that does not exist on
  #   # a real object. This is generally recommended, and will default to
  #   # `true` in RSpec 4.
  #   mocks.verify_partial_doubles = true
  # end

  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods
  config.include Rails.application.routes.url_helpers
  # config.include(LoginHelper::Feature, type: :feature)
  # config.include(LoginHelper::Controller, type: :controller)

  config.before(:all, type: :feature) do
    puts "I'm before(:all) in configuration file."
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        provider: 'twitter',
        uid: '12345',
        info: {
          nickname: 'netwillnet',
          image: 'http://example.com/netwillnet.jpg'
        }
        # ,
        # credentials: {
        #   token: 'mock_token',
        #   secret: 'mock_secret'
        # }
      })
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each)do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
