class SessionsController < ApplicationController
	def new
	end
	#kiem tra email va password cua nguoi dung login, sau do chuyen den trang profile
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			#log_in user
			#params[:session][:remember_me] == '1' ? remember(user) : forget(user)
			#redirect_back_or user
			#remember_me
			#redirect_to user
        if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
		else
    	flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
    	render 'new'
    end
end
def destroy
	log_out
	redirect_to root_url
end
end
