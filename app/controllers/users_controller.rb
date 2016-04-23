class UsersController < ApplicationController
	def index
		@users = User.all
		authorize @users
	end

	def destroy
		@user = User.find(params[:user_id])

		if @user.destroy
			flash[:notice] = "User deleted."
			redirect_to users_path
		else 
			flash[:alert] = "Failed to delete user."
		end
	end

	def upgrade
		@user = User.find(params[:user_id])
    	@user.update_attribute(:role, 'staff')
 
	    flash[:notice] = "Account changed to Staff"
	    redirect_to users_path
	end
end
