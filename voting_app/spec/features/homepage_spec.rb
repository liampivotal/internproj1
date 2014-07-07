require 'spec_helper.rb'

describe "The home page" do
  it "should have the title" do
    visit "/"
    expect(page).to have_content 'E-elections'
  end

  it "should have a navbar with a sign-in and register link" do
    visit "/"
    expect(page).to have_css('ul.nav li', text: 'Sign In')
    expect(page).to have_css('ul.nav li', text: 'Register')
  end
end
