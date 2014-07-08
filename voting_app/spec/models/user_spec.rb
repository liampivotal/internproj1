require 'spec_helper'

describe User do

  let(:user) { User.new({email: "guy@gmail.com",
                         password: "111111",
                         password_confirmation: "11111"
                       })
  }

  it "should respond to creating a new election" do
    pending("write later")
    #expect(user).to respond_to :create_a_match
  end
end
