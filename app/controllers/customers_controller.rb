class CustomersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_customer, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
  	@customers = Customer.paginate(page: params[:page])
  end

  def show
    @title = "Customer Profile"
  	@customer = Customer.find_by(id: params[:id])
    session[:customer] = @customer.id
    @account = @customer.accounts.build
    @accounts = @customer.accounts.where(Customer_id: session[:customer])
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

    def correct_customer
      @customer = Customer.find(params[:id])
      redirect_to unless current_customer?(@customer)
    end

    def admin_user
      
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
