require("capybara/rspec")
require("./app")
require("launchy")
require("pry")
Capybara.app = Sinatra::Application

describe ("path of the website" {:type => :feature}) do
  it ('shows shoes and stores') do
    visit('/')
    expect(page).to have_content('Welcome')
  end
end

#doesn't seem to be working
