module SessionsHelper

	# Logs in the given user.
	def log_in(customer)
		session[:customer_id] = customer.id
	end

	def log_out
		session.delete(:customer_id)
		@current_customer = nil
	end

	def current_customer
		@current_customer ||= Customer.find_by(id: session[:customer_id])
	end

	def current_customer?(customer)
		customer == current_customer
	end

	def customer
		@customer = Customer.find_by(id: session[:customer])
	end

	def logged_in?
		!current_customer.nil?
	end

	# Stores the url to be accessed.
	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end
end
