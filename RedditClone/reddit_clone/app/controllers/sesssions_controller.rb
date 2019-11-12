class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        user = User.find_by_credentials(user_params)
        if user
            sign_in(user)
            flash[:success] = "You're logged in!"
            redirect_to subs_url
        else
            flash[:errors] = "Invalid username/password combo"
            render :new
        end

    end

    def destroy
        current_user.reset_session_token!
        session[:session_token] = nil
        redirect_to subs_url
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end