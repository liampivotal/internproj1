class ElectionsController < ApplicationController

  def new
    @election = Election.new()
  end

  def show
    @election = Election.find(params[:id])
  end

  def create
    @election = Election.new(election_params)
    if @election.save
      owner_email = User.find(@election.owner_id).email
      email_array = params[:emails].split(',')
      email_array.include?(owner_email) ? nil : email_array << owner_email
      email_array.each do |email|
        @election.addParticipant(User.find_by(email: email))
      end
      #@election.addParticipant(User.find(@election.owner_id))
      flash[:notice] = 'Election was created'
      redirect_to @election
    else
      flash[:notice] = 'Error. Election was not created'
      render 'new'
    end
  end

  private

  def election_params
    params.require(:election).permit(:title, :owner_id)
  end
end
