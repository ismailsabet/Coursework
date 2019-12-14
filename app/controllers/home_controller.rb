class HomeController < ApplicationController
  def home
  end

  def contact
  end

  def request_contact
    name = params[:name]
    email = params[:email]
    message = params[:message]

    if email.blank?
      flash[:alert] = "No email"
    else
      ContactMailer.contact_email(email, name, message).deliver_now
      flash[:notice] = "Email sen!"
    end

  end
end
