require_relative '../../lib/validators.rb'

def test_phone_number(input, expected)
  describe ".phone_number? #{input}" do
    it { expect(Validators.phone_number?(input)).to eq expected }
  end
end

def test_date(input, expected)
  describe ".date? #{input}" do
    it { expect(Validators.date?(input)).to eq expected }
  end
end

def test_exists(input, expected)
  describe ".exists? #{input}" do
    it { expect(Validators.exists?(input)).to eq expected }
  end
end

RSpec.describe Validators do
  test_exists nil, false
  test_exists '', false
  test_exists 'foo', true
  test_exists '😀', true

  test_phone_number nil, false
  test_phone_number '', false
  test_phone_number '555', false
  test_phone_number '2025550176', false
  test_phone_number '12025550176', false
  test_phone_number '+12025550176', true
  test_phone_number '+102-555-176', false
  test_phone_number '+1😀345678901', false

  test_date nil, false
  test_date '', false
  test_date '2068-02-27', true
  test_date '68-02-27', false
  test_date '02-27-1968', false
end
