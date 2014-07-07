require 'spec_helper'

describe "Login and registration" do
  it "should be possible to navigate to login from the home page" do
    visit "/"
    click_link('Sign In')
    expect(page).to have_content('Email')
  end
  it "should be possible to navigate to register from the home page" do
    visit "/"
    click_link('Register')
    expect(page).to have_content('Password confirmation')
  end
end
