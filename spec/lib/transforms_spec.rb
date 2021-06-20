require_relative '../../lib/transforms'

def test_phone_number(input, expected)
  describe ".phone_number #{input}" do
    it { expect(Transforms.phone_number(input)).to eq expected }
  end
end

def test_date(input, expected)
  describe ".date #{input}" do
    it { expect(Transforms.date(input)).to eq expected }
  end
end

RSpec.describe Transforms do
  test_phone_number nil, nil
  test_phone_number '', ''
  test_phone_number '😀', '😀'
  test_phone_number 'foobar', 'foobar'
  test_phone_number '123456789', '123456789'
  test_phone_number '2025550176', '+12025550176'
  test_phone_number '12025550176', '+12025550176'
  test_phone_number '202-555-0176', '+12025550176'
  test_phone_number '+1 202-555-0176', '+12025550176'
  test_phone_number '(202) 555-0176', '+12025550176'
  test_phone_number '.202.555.0176', '+12025550176'

  test_date nil, nil
  test_date '', ''
  test_date 'foobar', 'foobar'
  test_date '2p27m168', '2p27m168'

  # POSIX boundaries
  test_date '2-27-68', '2068-02-27'
  test_date '2/27/69', '1969-02-27'
  # TODO: fix shorthand vs longhand years
  #test_date '2-27-1968', '2068-02-27'
  #test_date '2/27/1969', '1969-02-27'

  test_date '2/30/2000', '2/30/2000'
  test_date '12*2/2003', '12*2/2003'
  test_date '12*02/2003', '12*02/2003'
end
