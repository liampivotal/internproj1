require 'spec_helper.rb'

describe "Election Creation" do

  context "for logged in users" do
    before (:each) do
      login_as(user,scope: :user)
    end

    after (:each) do
      logout(:user)
    end

    let(:user) { User.new({email: "guy@gmail.com",
                           password: "111111",
                           password_confirmation: "11111"
                         })
    }

    it "should be available" do
      visit "/"
      expect(page).to have_content('Create an election')
    end

    it "should be able to access the Election Creation page" do
      visit "/"
      click_link('Create an election')
      expect(page).to have_content('Election name')
    end

    it "should see a title form to fill out" do
      visit new_election_path
      expect(page.has_field?("election_title")).to eq true
    end

    it "should result in them seeing their election after submitting the form" do
      "delete this line when other test is done being tested"
      visit new_election_path
      fill_in 'election_title', with: 'test election'
      click_button 'Create Election'
      expect(page).to have_content('test election')
    end
  end


  context "for users not logged in" do

    it "should not be available" do
      visit "/"
      expect(page).not_to have_content('Create an election')
    end
  end


end
