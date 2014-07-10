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


  context "for logged in users" do

    before (:each) do
      user.save!
      login_as(user,scope: :user)
    end

    after (:each) do
      logout(:user)
    end

    let(:user) { User.new({email: "guy@gmail.com",
                           password: "11111111",
                           password_confirmation: "11111111"
                         })
    }

    describe "who have not created or participated in any elections" do


      it "should not have a list of owned elections" do
        visit "/"
        expect(page).not_to have_content 'Elections that you own:'
      end

      it "should not have a list of elections participating in" do
        visit "/"
        expect(page).not_to have_content 'Elections that you are participating in:'
      end
    end

  end
end
