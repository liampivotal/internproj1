class Election < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :choices
  accepts_nested_attributes_for :choices, allow_destroy: true

  def addParticipant(participant)
    if participant.id == nil
      raise ArgumentError, 'participant has no id'
    end

    sql = "INSERT INTO elections_users (election_id, user_id)
           VALUES (#{id}, #{participant.id})"
    ActiveRecord::Base.connection.execute(sql)
  end

  def findParticipant(participant_id)
    self.users.find(participant_id)
  end

end
