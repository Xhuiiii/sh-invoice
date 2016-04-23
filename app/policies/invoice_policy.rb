class InvoicePolicy < ApplicationPolicy
	attr_reader :user, :invoice

	def initialize(user, invoice)
		@user = user
		@invoice = invoice
	end
	
	def create?
		staff?
	end

	def index?
		sk?
	end

	def show?
		staff?
	end

	def edit?
		staff?
	end

	def destroy?
		staff?
	end	

	def staff?
		@user.role == 'staff' || @user.role == 'sk'
	end	

	def sk?
		@user.role == 'sk'
	end
end