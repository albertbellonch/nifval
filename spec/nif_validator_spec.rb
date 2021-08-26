require 'nifval/nif_validator'

class Person
  include ActiveModel::Validations

  validates :testfield, :nif => true

  attr_accessor :testfield

  def initialize testfield
    @testfield = testfield
  end
end

describe Nifval::NifValidator do
  def nif_validity nif, ok
    test = Person.new(nif)
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
end
