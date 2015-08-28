class Insurance < ActiveRecord::Base
	belongs_to :User
	validates :first_name, presence: true, length: {maximum: 50, minimum: 2}
	validates :last_name, presence: true, length: {maximum: 100, minimum: 2}
	# If there is a standard for enrolee_id I'd love to see it, but I don't know what it is.
	validates :enrolee_id, presence: true, length: {maximum: 20, minimum: 5} 
	validates :group_number, presence: true, length: {maximum: 20, minimum: 5} 
	validates :user_id, uniqueness: true
end
