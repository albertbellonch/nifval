require 'spec_helper'

class Test
  include ActiveModel::Validations

  validates :testfield, :nif => true

  attr_accessor :testfield

  def initialize testfield
    @testfield = testfield
  end
end

describe NifVal do
  def nif_validity nif, ok
    test = Test.new(nif)
    test.valid?.should == ok
  end

  # Correct NIFs
  context "when we check valid NIFs" do
    it "should return OK" do
      nif_validity "00000000T", true
    end
  end

  # Invalid NIFs
  context "when we check invalid NIFs" do
    it "should return ERROR" do
      nif_validity "12345678T", false
    end
  end

  # Correct CIFs
  context "when we check valid CIFs" do
    it "should return OK" do
      nif_validity "A12345674", true
    end
  end

  # Invalid CIFs
  context "when we check invalid CIFs" do
    it "should return ERROR" do
      nif_validity "A2345678C", false
    end
  end

  # Correct NIEs
  context "when we check valid NIEs" do
    it "should return OK" do
      nif_validity "X1230123Z", true
    end
  end

  # Incorrect NIEs
  context "when we check invalid NIEs" do
    it "should return ERROR" do
      nif_validity "X1230123F", false
    end
  end

  # Bad format
  context "when we check for badly-formatted strings" do
    it "should return ERROR" do
      nif_validity nil, false
    end

    it "should return ERROR" do
      nif_validity "cucamonga", false
    end

    it "should return ERROR" do
      nif_validity "0000 0000 T", false
    end

    it "should return ERROR" do
      nif_validity "123A123AA", false
    end

    it "should return ERROR" do
      nif_validity "123456753215X1230123Z", false
    end
  end

end
