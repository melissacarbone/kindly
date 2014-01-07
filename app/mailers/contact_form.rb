class ContactForm < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_form.receipt.subject
  #
  def receipt(contactform)
    @contactform = contactform
    mail from: contactform[:email], to: 'mcarbone1@gmail.com', subject: 'New Contact Form'
  end
end
