require 'spec_helper.rb'

describe "Match Creation" do
  it "should be available for logged-in users" do
    #create a signed in user
    user1 = User.new({email: "guy@gmail.com",
              password: "111111",
              password_confirmation: "111111"
              }).save(validate: false)
    #sign_in user1


  end
end
