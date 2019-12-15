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
      flash[:alert] = I18n.t('home.request_contact.no_email')
      redirect_back(fallback_location: root_path)
    else
      # send the email
      ContactMailer.contact_email(email, name, message).deliver_now
      flash[:notice] = I18n.t('home.request_contact.email_sent')
      redirect_back(fallback_location: root_path)
    end

  end
end
