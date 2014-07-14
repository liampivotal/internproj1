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

  context "when another user has created an election this user is part of" do

    let(:user) { User.new({email: "guy@gmail.com",
                           password: "11111111",
                           password_confirmation: "11111111"
                         })
    }

    let(:user2) { User.new({email: "dog@dog.com",
                           password: "11111111",
                           password_confirmation: "11111111"
                         })
    }

    before (:each) do
      user.save!
      user2.save!

      login_as(user, scope: :user)
      visit new_election_path
      fill_in 'election_title', with: 'test election'
      fill_in 'emails', with: 'dog@dog.com'
      fill_in 'options1', with: 'red'
      fill_in 'options2', with: 'blue'
      click_button 'Create Election'
      logout(:user)

      login_as(user2, scope: :user)
    end

    after (:each) do
      logout(:user2)
    end

    it "should see that election" do
      visit '/'
      expect(page).to have_content('test election')
    end

    it "should be able to vote in that election (and only once)", js: true do
      visit '/'
      click_link('test election')
      find("input[value='red']").click
      expect(page).to_not have_content('You have already voted in this election!')
      click_button 'Submit Vote'
      expect(page).to have_content('You voted for red in the election test election')
      click_link('test election')
      expect(page).to have_content('You have already voted in this election!')
    end
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
