class UserPolicy < ApplicationPolicy
	attr_reader :user

	def initialize(user, record)
		@user = user
	end

	def index?
		sk?
	end

	def destroy?
		sk?
	end

	def update?
		sk?
	end

	def sk?
		@user.role == 'sk'
	end
end