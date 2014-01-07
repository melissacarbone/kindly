class ContactForm < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_form.receipt.subject
  #
  def receipt
    @greeting = "Hi"

    mail to: 'to@example.com'
  end
end
