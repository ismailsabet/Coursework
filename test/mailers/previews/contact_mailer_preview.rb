# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  def contact_email
    ContactMailer.contact_email("foo@bar.com", "Foo Bar", @message = "Testing the mailer")
  end

end
