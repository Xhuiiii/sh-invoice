class InvoicesController < ApplicationController
  def new 
  	@invoice = Invoice.new
  end

  def create
  	@invoice = Invoice.new 
  	@invoice.name = params[:invoice][:name]
  	@invoice.address = params[:invoice][:address]
  	@invoice.identification = params[:invoice][:identification]
  	@invoice.dob = params[:invoice][:dob]
  	@invoice.phone = params[:invoice][:phone]
  	@invoice.email = params[:invoice][:email]
  	@invoice.room = params[:invoice][:room]
  	@invoice.days = params[:invoice][:days] 
  	@invoice.rate = params[:invoice][:rate] 

  	if @invoice.save
  		flash[:notice] = "Invoice saved."
  		redirect_to @invoice
  	else 
  		flash[:alert] = "Invoice cannot be saved. Please try again."
  	end
  end

  def index
  	@invoices = Invoice.all
  end

  def show
  	@invoice = Invoice.find(params[:id])
  	#Set default values for room rates(RM 118) or Days stayed
  	@invoice.rate ||= 118
  	@invoice.days ||= 1

  	@total = @invoice.rate * @invoice.days
  	@gst = @total * 0.06
  	@net = @total - @gst
  end
end
