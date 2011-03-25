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

  # Random NIFs
  it "should be valid" do
    nif_validity "00000000T", true
  end

  it "should be valid" do
    nif_validity "01230123Z", true
  end

  # Random CIFs
  it "should be valid" do
    nif_validity "A12345674", true
  end

  it "should be valid" do
    nif_validity "W98765431", true
  end

  # Random NIEs
  it "should be valid" do
    nif_validity "X1230123Z", true
  end

  it "should be valid" do
    nif_validity "Z0000000M", true
  end

  # Invalid values
  it "should not be valid" do
    nif_validity "A2345678C", false
  end

  it "should not be valid" do
    nif_validity nil, false
  end

  it "should not be valid" do
    nif_validity "cucamonga", false
  end

  it "should not be valid" do
    nif_validity "a b 1 5", false
  end


end
