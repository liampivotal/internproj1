require 'spec_helper.rb'

describe "Election Creation" do

  context "for logged in users" do
    before (:each) do
      user.save!
      user2.save!
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

    let(:user2) { User.new({email: "dog@dog.com",
                           password: "11111111",
                           password_confirmation: "11111111"
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
      visit new_election_path
      fill_in 'election_title', with: 'test election'
      fill_in 'options1', with: 'red'
      fill_in 'options2', with: 'blue'
      click_button 'Create Election'
      expect(page).to have_content('test election')
      visit '/'
      expect(page).to have_content('test election')
    end

    it "should be able to accept an email" do
      visit new_election_path
      fill_in 'election_title', with: 'test election'
      fill_in 'emails', with: 'dog@dog.com'
      fill_in 'options1', with: 'red'
      fill_in 'options2', with: 'blue'
      click_button 'Create Election'
      expect(page).to have_content('Voters in election:')
      expect(page).to have_content('dog@dog.com')
      expect(page).to have_css('ol li', text: 'guy@gmail.com')
    end

    it "should be able to add users to the election after creation" do
      visit new_election_path
      fill_in 'election_title', with: 'test election'
      fill_in 'options1', with: 'red'
      fill_in 'options2', with: 'blue'
      click_button 'Create Election'
      fill_in 'Add new emails', with: 'dog@dog.com'
      click_button 'Update Election'
      expect(page).to have_content('dog@dog.com')

    end


    it "should be able to accept voting choices" do
      visit '/'
      click_link 'Create an election'
      fill_in 'election_title', with: 'another election'
      fill_in 'options1', with: 'Red'
      fill_in 'options2', with: 'Blue'
      click_button 'Create Election'
      expect(page).to have_content('Choices to vote for')
      expect(page).to have_content('Red')
      expect(page).to have_content('Blue')
    end
  end

  context "for users not logged in" do

    it "should not be available" do
      visit "/"
      expect(page).not_to have_content('Create an election')
    end
  end


end
