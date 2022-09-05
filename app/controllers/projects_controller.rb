class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @challenge = Challenge.find(@project.challenge_id)
  end

  def update
    @project = Project.find(params[:id])
    @project.contestants << Contestant.find(params[:contestant_id])
    redirect_to "/projects/#{@project.id}"
  end
end