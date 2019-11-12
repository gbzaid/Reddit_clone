class UsersController < ApplicationController
    def new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Welcome to Reddit"
            redirect_to subs_url
        else
            flash[:errors] = "Invalid username/password"
            render :new
        end
    end

    def destroy
        @user = User.find_by(params[:id])
        if @user.destroy
            flash[:success] = "You have successfully deleted this user."  
            redirect_to subs_url
        else
            flash[:errors] = "We could not delete this user for some reason."
            redirect_to user_url(@user)
        end
    end

    def show
        render :show
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end