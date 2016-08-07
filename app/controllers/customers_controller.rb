class CustomersController < ApplicationController
  def index
  	
  end

  def show
  	
  end

  def new
  	@customer = Customer.new
  end

  def create
  	@customer = Customer.new(user_params)
  	if @customer.save
  		# Handle a successful save.
      log_in @customer
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @customer
  	else
  		render 'new'
  	end
  end

  def edit
  	
  end

  def update
  	
  end

  def delete
  	
  end

  private

  	def user_params
  		params.require(:customer).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  	end

end
