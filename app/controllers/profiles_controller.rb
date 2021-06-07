class ProfilesController < ApplicationController
  def show
    @profile = User.includes(:articles, :favoriters, :followers).where(name: params[:username]).first!
    @title = "#{@profile.name} | Sawir Forum"
  end
end
