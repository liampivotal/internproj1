require "spec_helper"

describe ElectionsController do

  let (:election_params) {{ title: "test title" }}

  let(:user1) {User.new({email: "guy@gmail.com",
                                      password: "11111111",
                                      password_confirmation: "11111111"
                                    })}

  let(:user2) {User.new({email: "guy2@gmail.com",
                                      password: "11111111",
                                      password_confirmation: "11111111"
                                    })}
  before (:each) do
    user1.save!
    user2.save!
  end

  describe "#create" do

    it "should create a new election in the database" do

      testElection = Election.create(election_params)
      expect(Election.find(testElection.id)).to eq testElection
    end

    it "should properly assign the owner id" do
      ownedElection = Election.create({ owner_id: user1.id, title: 'owned election' })
      expect(ownedElection.owner_id).to eq user1.id
    end
  end

  describe "#addParticipant/#findParticipant" do
    it "should implement the methods correctly" do
      user1.save!
      user2.save!
      testElection = Election.create(election_params)
      testElection.addParticipant(user1)
      expect(testElection.findParticipant(user1.id)).to eq user1
      foundUser2 = true
      begin
        testElection.findParticipant(user2.id)
      rescue Exception => e
        foundUser2 = false
      end
      expect(foundUser2).not_to eq true
    end
  end

  describe "#vote" do
    it "should update the vote count in an election" do
      user1.save!
      testElection = Election.new({ owner_id: user1.id, title: 'owned election'})
      testElection.save
      Choice.create(election_id: testElection.id, name: 'red')
      Choice.create(election_id: testElection.id, name: 'blue')
      choices = Choice.where(election_id: testElection.id)
      #p choices.find_by(name:'red')['votes']
      expect(choices.find_by(name:'red')["votes"]).to eq 0
      expect(choices.find_by(name:'blue')["votes"]).to eq 0
      testElection.vote(user1.id, 'blue')
      expect(choices.find_by(name:'blue')["votes"]).to eq 1
      expect(choices.find_by(name:'red')["votes"]).to eq 0
    end
  end

end
