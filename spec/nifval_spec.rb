require 'nifval/nif'

describe Nifval::Nif do
  def nif(string)
    Nifval::Nif.new(string)
  end

  context "valid DNIs" do
    it { nif("00000000T").should be_valid }
    it { nif("00000000T").should be_valid_dni }
  end

  context "invalid DNIs" do
    it { nif("12345678T").should_not be_valid }
    it { nif("0xxxxxxxT").should_not be_valid_dni }
  end

  context "valid CIFs" do
    it { nif("A12345674").should be_valid }
    # Edge case: check digit is 0
    it { nif("A16345670").should be_valid }

    # Using letters!
    it { nif("Q1234567D").should be_valid }
    # Edge case: check digit is J
    it { nif("Q1634567J").should be_valid }
  end

  context "invalid CIFs" do
    it { nif("A2345678C").should_not be_valid }
    it { nif("02345678C").should_not be_valid_cif }
  end

  context "valid 'special'" do
    it { nif("K1234567D").should be_valid_special }
    # L -> letter or digit
    it { nif("L1234567D").should be_valid_special }
    it { nif("L12345674").should be_valid_special }
  end

  context "invalid special" do
    # K -> letter
    it { nif("K12345674").should_not be_valid_special }
    it { nif("02345678C").should_not be_valid_special }
  end

  context "valid NIEs" do
    it { nif("X1230123Z").should be_valid }
  end

  context "invalid NIEs" do
    it { nif("X1230123F").should_not be_valid }
    it { nif("00000000T").should_not be_valid_nie }
  end

  context "alternatively-formatted strings" do
    # Accept with length < 9
    it { nif("T").should be_valid }
    # Accept lowercase
    it { nif("00000000t").should be_valid }
  end

  context "badly-formatted strings" do
    it { nif(nil).should_not be_valid }
    it { nif("cucamonga").should_not be_valid }
    it { nif("0000 0000 T").should_not be_valid }
    it { nif("123A123AA").should_not be_valid }
    it { nif("123456753215X1230123Z").should_not be_valid }
  end

end
