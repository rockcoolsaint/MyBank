module SessionsHelper

	# Logs in the given user.
	def log_in(customer)
		session[:customer_id] = customer.id
	end
end
