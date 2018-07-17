class ContactController < ApplicationController
  def index
    @contact = Contact.new
  end

  def create
  	@contact = Contact.new(contact_params)

  	respond_to do |format|
    	if @contact.save
    		ContactMailer.contact_us(@contact).deliver
        format.json { render json: "success" }
     	else
    		format.html { render :action => "index" }
    	end
    end
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :number, :message)
  end
end
