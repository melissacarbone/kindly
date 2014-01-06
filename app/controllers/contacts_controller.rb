class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to new_contact_path, notice: 'Form was successfully submitted.'
    else
      render 'new', notice: 'There was an error processing your form.'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :subject, :description, :first_name, :last_name)
  end
end
