Capybara.register_driver :firefox do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(marionette: false)

  Selenium::WebDriver.for :firefox, desired_capabilities: capabilities

  Capybara::Selenium::Driver.new(app, browser: :firefox, desired_capabilities: capabilities)
end

Capybara.javascript_driver = ENV.fetch('CAPYBARA_JAVASCRIPT_DRIVER', :chrome_headless).to_sym
