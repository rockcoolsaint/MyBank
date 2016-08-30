class Account < ActiveRecord::Base
  belongs_to :customer

  validates :acc_type, presence: true
  validates :acc_balance, presence: true

  before_save :generate_account_number

  private
  	def generate_account_number
  		self.acc_num = PerfectRandom::rand.to_s if new_record?
  	end
end
