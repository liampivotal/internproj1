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
  it "should allow a user to sign in and sign out" do
    visit "/user/sign_up"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    expect(page).to have_content('Sign Out')
    expect(page).to have_content('user@example.com')

    click_link('Sign Out')
    expect(page).to have_content('Sign In')
    expect(page).to have_content('Register')
  end

end
