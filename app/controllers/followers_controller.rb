class FollowersController < ApplicationController
  before_action :authenticate

  def create
    user = User.where(name: params[:username]).first
    follower = current_user
    profile = Follower.new(user_id: user.id, follower_id: follower.id)
    redirect_back(fallback_location: profile_path(user.name)) if profile.save
  end

  def destroy
    user = User.where(name: params[:username]).first
    follower = Follower.where(follower_id: current_user.id, user_id: user.id).first
    redirect_back(fallback_location: profile_path(user.name)) if follower.destroy
  end
end
