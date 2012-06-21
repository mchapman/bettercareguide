require 'test_helper'

class SendcodeTest < ActionMailer::TestCase
  setup do
    @a_user = users(:punter)
    @a_person = people(:one)
    @a_person.user = @a_user
    @a_user.person = @a_person
    @a_permission = permissions(:one)
    @a_service = services(:one)
    @a_service.organisation = organisations(:organisations_001)
    @a_service.organisation.addresses << addresses(:addresses_001)
    @a_service.organisation.phones << phones(:phones_001)
  end

  test "by_fax" do
    mail = Sendcode.by_fax(@a_permission, @a_service, @a_user)
    assert_equal "Sending code by fax", mail.subject
    assert_equal ["bettercareguide@reallycare.org"], mail.from
    assert_match "For the attention of", mail.body.encoded
    assert_match "99999", mail.body.encoded
  end

  test "by_landline" do
    mail = Sendcode.by_landline(@a_permission, @a_service, @a_user)
    assert_equal "Sending code by landline", mail.subject
    assert_equal ["bettercareguide@reallycare.org"], mail.from
    assert_match "This is a message for", mail.body.encoded
    assert_match "99999", mail.body.encoded
  end

  test "by_mail" do
    mail = Sendcode.by_mail(@a_permission, @a_service, @a_user)
    assert_equal "Sending code by snail mail", mail.subject
    assert_equal ["bettercareguide@reallycare.org"], mail.from
    assert_match "Dear ", mail.body.encoded
    assert_match "99999", mail.body.encoded
  end

  test "rescan" do
    mail = Sendcode.rescan(@a_service, @a_user)
    assert_equal "Rescan a service", mail.subject
    assert_equal ["bettercareguide@reallycare.org"], mail.from
    assert_match "rescan the regulator site", mail.body.encoded
  end

  test "figure_something_out" do
    mail = Sendcode.figure_something_out(@a_service, '087766523',@a_user)
    assert_equal "Figure something out", mail.subject
    assert_equal ["bettercareguide@reallycare.org"], mail.from
    assert_match "figure out a way of", mail.body.encoded
  end

end
