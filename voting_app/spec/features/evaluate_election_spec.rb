require 'spec_helper.rb'

describe 'Evaluating election results' do

  let(:user1) { User.new({email: "guy@gmail.com",
                         password: "11111111",
                         password_confirmation: "11111111"
                       })
  }

  let(:user2) { User.new({email: "dog@dog.com",
                         password: "11111111",
                         password_confirmation: "11111111"
                       })
  }

  let(:user3) { User.new({email: "some@dude.com",
                         password: "11111111",
                         password_confirmation: "11111111"
                       })
  }

  it 'Election setup and evaluation' do

    user1.save!
    user2.save!
    user3.save!
    testElection = Election.new({ owner_id: user1.id, title: 'owned election'})
    testElection.save
    testElection.addParticipant(user1)
    testElection.addParticipant(user2)
    testElection.addParticipant(user3)
    Choice.create(election_id: testElection.id, name: 'red')
    Choice.create(election_id: testElection.id, name: 'blue')

    choices = Choice.where(election_id: testElection.id)

    testElection.vote(user1.id, 'blue')
    testElection.vote(user2.id, 'blue')
    testElection.vote(user3.id, 'red')

    login_as(user1, scope: :user)
    visit '/'
    first('.owned').click_link('owned election')
    expect(page).to have_content('Choices to vote for') #expect to be in the election page
    expect(page).to_not have_content('blue won!')
    #print page.html
    click_link('End election and evaluate results')
    expect(page).to have_content('blue won!')
    logout(:user)

    login_as(user2, scope: :user)
    visit '/'
    click_link('owned election')
    expect(page).to have_content('blue won!')
    logout(:user)

  end
end
