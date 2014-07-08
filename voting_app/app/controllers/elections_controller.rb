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
      flash[:notice] = 'Election was created'
      redirect_to @election
    else
      flash[:notice] = 'Error. Election was not created'
      render 'new'
    end

  end

  private

  def election_params
    params.require(:election).permit(:title)
  end
end
