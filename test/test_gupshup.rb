$:.unshift File.dirname(__FILE__)
require 'test_helper'
class TestGupshup < Test::Unit::TestCase

  def setup
  	@gup = Gupshup::Enterprise.new(:userid => '19009888', :password => 'test')
  end
  
  def test_truth
    assert_equal([true, nil], @gup.send_text_message(msg: "Testing", send_to: "919453456689"))
  end

  def test_failure
    assert_not_equal([true, nil], @gup.send_text_message(msg: "Testing", send_to: "4567777888"))
  end

  def test_creditional
  	assert_raise( RuntimeError ){Gupshup::Enterprise.new(userid: "")}
  end

  def test_short_phone_number
  	assert_equal([false, "Phone Number is too short"], @gup.send_text_message(msg: "Testing", send_to: "9194567890"))
  end

  def test_long_phone_number
  	assert_equal([false, "Phone Number is too long"], @gup.send_text_message(msg: "Testing", send_to: "91945678901123"))
  end
  
  def test_string
  	assert_equal([false, "Phone Number should be numerical value"], @gup.send_text_message(msg: "Testing", send_to: "hellotest123"))
  end

  def test_empty_msg
  	assert_equal([false, "Message cannot be empty"], @gup.send_text_message(msg: "", send_to: "919453456689"))
  end

end
