module SessionsHelper

	# Logs in the given user.
	def log_in(customer)
		session[:customer_id] = customer.id
	end

	def log_out
		session.delete(:customer_id)
		@current_customer = nil
	end

	# remembers in a persistent session
	def remember(customer)
		cookies.permanent.signed[:customer_id] = customer.id 
	end

	# returns the current user if any
	def current_customer
		if session[:customer_id]
			@current_customer ||= Customer.find_by(id: session[:customer_id])
		elsif cookies.signed[:customer_id]
			customer = Customer.find_by(id: cookies.signed[:customer_id])
			if customer
				log_in customer
				@current_customer = customer
			end
		end
	end

	def current_customer?(customer)
		customer == current_customer
	end

	#def customer
	#	@customer = Customer.find_by(id: session[:customer])
	#end

	def logged_in?
		!current_customer.nil?
	end

	# Stores the url to be accessed.
	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end
end
