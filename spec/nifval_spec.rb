require 'nifval/nif'

describe Nifval::Nif do
  def nif(string)
    Nifval::Nif.new(string)
  end

  # Correct NIFs
  context "when we check valid NIFs" do
    it { nif("00000000T").should be_valid }
  end

  # Invalid NIFs
  context "when we check invalid NIFs" do
    it { nif("12345678T").should_not be_valid }
  end

  # Correct CIFs
  context "when we check valid CIFs" do
    it { nif("A12345674").should be_valid }
    # Edge case: check digit is 0
    it { nif("A16345670").should be_valid }
  end

  # Invalid CIFs
  context "when we check invalid CIFs" do
    it { nif("A2345678C").should_not be_valid }
  end

  # Correct NIEs
  context "when we check valid NIEs" do
    it { nif("X1230123Z").should be_valid }
  end

  # Incorrect NIEs
  context "when we check invalid NIEs" do
    it { nif("X1230123F").should_not be_valid }
  end

  # Good format
  context "when we check alternatively-formatted strings" do
    # Accept with length < 9
    it { nif("T").should be_valid }
    # Accept lowercase
    it { nif("00000000t").should be_valid }
  end

  # Bad format
  context "when we check for badly-formatted strings" do
    it { nif(nil).should_not be_valid }
    it { nif("cucamonga").should_not be_valid }
    it { nif("0000 0000 T").should_not be_valid }
    it { nif("123A123AA").should_not be_valid }
    it { nif("123456753215X1230123Z").should_not be_valid }
  end

end
