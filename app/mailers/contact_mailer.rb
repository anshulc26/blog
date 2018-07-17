class ContactMailer < ActionMailer::Base
  default from: "anshulsorrow@gmail.com"

  def contact_us(contact)
    @contact=contact
    mail( :to => "anshul.c26@gmail.com", :subject => "Site Visit" )
  end
end
