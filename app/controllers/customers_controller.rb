class CustomersController < ApplicationController
  def index
  	@customers = Customer.paginate(page: params[:page])
  end

  def show
    @title = "Customer Profile"
  	@customer = Customer.find(params[:id])
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
  	@customer = Customer.find(params[:id])
  end

  def update
  	@customer = Customer.find(params[:id])
    if @customer.update_attributes(user_params)
      # Handle a successful update
      flash[:success] = "Profile updated"
      redirect_to @customer
    else
      render 'edit'
    end
  end

  def destroy
  	Customer.find(params[:id]).destroy
    flash[:success] = "Customer deleted"
    redirect_to customers_url
  end

  private

  	def user_params
  		params.require(:customer).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  	end
end
