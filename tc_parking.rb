require_relative "Parking"
require "test/unit"


class TestParking < Test::Unit::TestCase
  # Sample test case 1
  def test_slot_no
    p = Parking.new(2)
    p.park("KA-4533 White")
    assert_equal(1, p.slot_number_for_registration_number("KA-4533"))
  end

  # Sample test case 2
  def test_reg_numbers
    p = Parking.new(2)
    p.park("KA-4533 White")
    p.park("KA-1299 White")
    assert_equal("KA-4533,KA-1299", p.registration_numbers_for_cars_with_colour("White"))
  end
end