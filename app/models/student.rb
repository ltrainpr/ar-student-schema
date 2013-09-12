require 'date'
require_relative '../../db/config'

class Student < ActiveRecord::Base

	validates :email, :format => {:with => /\A(.+)@(.+)\.(..)/}, uniqueness: true
	validates :age, :numericality => {:greater_than_or_equal_to => 5}
	validate :phone_ten_digits
	# validates :phone, :numericality => {:only_integer => true}
	# validates :phone, :format => {:with => /[0-9]{3}-[0-9]{3}-[0-9]{4}/}


	def name
		"#{first_name} #{last_name}"
	end

	def age
		now = Date.today
		@age = now.year - self.birthday.year - (self.birthday.to_date.change(:year => now.year) > now ? 1 : 0)
	end

	def phone_ten_digits
		a = phone.gsub(/\D/, "")
		unless a.length >= 10
			errors.add(:phone, "Invalid Phone Number")
		end
	end


end