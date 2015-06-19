ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }



RSpec.configure do |config|
  config.after(:each) do
    Shoe.all().each() do |shoe|
      shoe.destroy()
    end
    Store.all().each() do |store|
      store.destroy()
    end
  end
end
