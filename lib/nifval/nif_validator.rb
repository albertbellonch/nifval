require 'nifval/nif'
require "active_model"

module Nifval
  class NifValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if value.nil? || !Nifval::Nif.new(value).valid?
        record.errors.add(attribute, options[:message] || I18n.t("nifval.wrong"))
      end
    end
  end
end

ActiveModel::Validations.send(:include, Nifval)
