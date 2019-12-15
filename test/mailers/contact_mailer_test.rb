require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase

  test "should return contact email" do
    mail = ContactMailer.contact_email("foo@bar.com", "Foo", @message = "Hello")

    assert_equal ['foo@bar.com'], mail.to
    assert_equal ['foo@bar.com'], mail.from
  end


end
