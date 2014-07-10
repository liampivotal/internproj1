require 'spec_helper'

describe User do

  let(:user) { User.new({email: "guy@gmail.com",
                         password: "111111",
                         password_confirmation: "11111"
                       })
  }

end
