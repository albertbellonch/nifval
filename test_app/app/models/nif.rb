class Nif < ActiveRecord::Base
  validates :value, :nif => true
end
