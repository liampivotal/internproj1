require "spec_helper"

describe ElectionsController do

  describe "#create" do

    let (:election_params) {{ title: "test title" }}

    it "should create a new election in the database" do

      testElection = Election.create(election_params)
      expect(Election.find(testElection.id)).to eq testElection
    end



  end

end
