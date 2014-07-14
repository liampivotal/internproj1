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

  def voted?(user_id)
    sql = "SELECT * FROM elections_users
           WHERE election_id = #{self.id}
           AND user_id = #{user_id};"
    result = ActiveRecord::Base.connection.execute(sql)[0]
    result["voted"] != 'f'
  end

  def vote(user_id, vote_choice)
    sql="UPDATE elections_users
          SET voted = 't'
          WHERE user_id = #{user_id}
          AND election_id = #{id};"
    ActiveRecord::Base.connection.execute(sql)
    choice = Choice.find_by(election_id: id, name: vote_choice)
    choice.votes += 1
    choice.save
  end

  def evaluate_election
    winner = 0
    self.choices.each do |choice|
      if choice.votes > winner
        winner = choice.votes
        self.winner_id = choice.id
        self.status = "winner"
      elsif choice.votes == winner
        self.status = "tie"
        self.winner_id = choice.id
      end
    end
    self.save
  end
end
