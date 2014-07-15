class ElectionsController < ApplicationController

  def new
    @election = Election.new()
  end

  def show
    @election = Election.find(params[:id])
  end

  def validElection?
    email_array = params[:emails].split(',')
    email_array.each do |email|
      if User.find_by(email: email.strip) == nil
        flash[:notice] = "There is no user with email #{email}"
        return false
      end
    end
    if params[:election][:title] == ""
      flash[:notice] = 'Election requires a title'
      return false
    end
    choices_array = params[:options]
    number_of_choices = 0
    choices_array.each do |index, choice|
      number_of_choices += 1 unless choice == ""
    end
    if !(number_of_choices > 1)
      flash[:notice] = 'Election requires at least two voting choices'
      return false
    end
    return number_of_choices > 1
  end

  def create
    @election = Election.new(election_params)
    if !validElection?
      render 'elections/new'
      return
    end
    if @election.save
      params[:options].each do |index,name|
        Choice.create(election_id: @election.id, name: name)
      end
      owner_email = User.find(@election.owner_id).email
      email_array = params[:emails].split(',')
      email_array << owner_email unless email_array.include?(owner_email)
      email_array.each do |email|
        @election.addParticipant(User.find_by(email: email.strip))
      end

      flash[:notice] = 'Election was created'
      redirect_to @election
    else
      flash[:notice] = 'Error. Election was not created'
      render 'new'
    end
  end

  def evaluate_election
    @election = Election.find(params[:id])
    @election.evaluate_election
    redirect_to @election
  end

  def addParticipants
    @election = Election.find(params[:id])
    emails = params[:emails]
    existing_emails = @election.users.map{|user| user.email}
    emails.split(',').each do |email|
      name = email.strip()
      if !existing_emails.include?(name)
        @election.addParticipant(User.find_by(email: email))
      end
    end
    redirect_to @election
  end

  def vote
    @election = Election.find(params[:election_id])
    flash[:notice] = "You voted for #{params[:elections_controller][:vote]} in the election #{@election.title}"
    @election.vote(params[:user_id], params[:elections_controller][:vote])
    redirect_to root_path
  end
  private

  def userToEmail(user)
    user.email
  end

  def election_params
    params.require(:election).permit(:title, :owner_id)
  end
end
