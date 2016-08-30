class UserFavoriteMicropostsController < ApplicationController

#   before_action :logged_in_user

#   def create
#     @user = User.find(params[:followed_id])
#     followings_user.follow(@user)
#   end

#   def destroy
#     @user = followings_user.following_relationships.find(params[:id]).followed
#     followings_user.unfollow(@user)
#   end
end