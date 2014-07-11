class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #has_many :elections
  has_and_belongs_to_many :elections

  def ownedElections
    Election.where(owner_id: self.id)
  end

  def participatingElections
    self.elections
  end
end
