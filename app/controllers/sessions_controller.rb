class SessionsController < ApplicationController
  def new
  	@title = "Log in"
  end

  def create
  	customer = Customer.find_by(email: params[:session][:email].downcase)
    if customer && customer.authenticate(params[:session][:password])
    	# Log the user in and redirect to the user's show page.
      #log_in customer
      #redirect_to customer
    else
    	# Create an error message
    	flash.now[:danger] = 'Invalid email/password combination'
    	@title = "Log in"
  		render 'new'
  	end
  end

  def destroy
  end
end