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
    @invoice.date = Time.now
    @invoice.special = params[:invoice][:special]

  	if @invoice.save
  		flash[:notice] = "Invoice saved."
  		redirect_to @invoice
  	else 
  		flash[:alert] = "Invoice cannot be saved. Please try again."
  	end
  end

  def index
    @startDate = params[:startD]
    @endDate = params[:endD]
    status = params[:status]


    # if (status == nil || status == "all") 
    #   @invoices = Invoice.all.where(:date => @startDate..@endDate)
    # elsif status == "normal"
    #   @invoices = Invoice.all.where(:date => startDate..endDate, :special => false)
    # elsif status == "special"
    #   @invoices = Invoice.all.where(:date => startDate..endDate, :special => true)
    # end

    @invoices = Invoice.all

    @rooms = 0
    @money = 0

    @invoices.each do |inv|
      @rooms += 1
      if inv.rate == nil
        inv.rate = 118
      end
      @money += inv.rate
    end

    authorize @invoices
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
