class AccountsController < ApplicationController
	#before_action :correct_customer, only: [:edit, :update]
	before_action :logged_in_user, only: [:create, :edit, :update]
	before_action :admin_user, only: [:index]

	def index
		@accounts = Account.paginate(page: params[:page])
	end

	def show
		@account = current_customer.accounts.build
		@transact = current_customer.accounts.build
		current_account = Account.find(params[:id])
		@account_balance = current_account.acc_balance
	end

	def new

	end

	def create
		@account = @current_customer.accounts.build(account_params)
		if @account.save
			flash[:success] = "Account successfully created!"
			redirect_to @current_customer
		else
			flash[:danger] = "Account creation failed!"
			redirect_to @customer
		end
	end

	def edit
		@title = "Transaction"
		@account = current_customer.accounts.find(params[:id])
		@account_balance = @account.acc_balance
	end

	def update
		@account = Account.find(params[:id])
		account_balance = @account.acc_balance
		@amount = params[:account][:amount].to_i
		if params[:commit] == "Withdraw"
			account_balance -= @amount
			if @account.update_attribute(:acc_balance, account_balance)
				flash.now[:success] = "Withdrawal of N#{@amount} successful"
      			render 'edit'
      		else
      			flash.now[:danger] = "Oops! Withdrawal failed!"
      			render 'edit'
      		end
      	else
      		account_balance += @amount
			if @account.update_attribute(:acc_balance, account_balance)
				flash.now[:success] = "Deposit of N#{@amount} successful"
	      		render 'edit'
	      	else
	      		flash.now[:danger] = "Oops! Withdrawal failed!"
	      		render 'edit'
	      	end
      	end
	end

	

	private

		def deposit
			
		end

		def account_params
			params.require(:account).permit(:acc_type, :acc_balance)
		end

		# ensure its the correct customer
		def correct_customer
			@account = current_customer.accounts.find_by(id: params[:id])
			redirect_to root_path if !(@account.customer_id == @current_customer.id)
		end

		def admin_user
	      redirect_to(root_url) unless current_customer.admin?
	    end
end
