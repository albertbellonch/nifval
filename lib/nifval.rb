# encoding: utf-8
# Adapted from http://compartecodigo.com/javascript/validar-nif-cif-nie-segun-ley-vigente-31.html
require "active_model"

module Nifval
  class NifValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if !is_valid_nif value
        record.errors.add(attribute, I18n.t("nifval.wrong"))
      end
    end

    private

    def is_valid_nif nif
      # NIF not provided
      return false if nif.nil?

      # Add zeros to the left if applyable, and accept lowercase
      nif = nif.rjust(9,'0')
      nif = nif.upcase

      # Format
      return false if
        !nif.match(/^[A-Z]{1}\d{7}[A-Z0-9]{1}$/) && !nif.match(/^[0-9]{8}[A-Z]{1}$/)

      if nif.match(/^[0-9]{8}[A-Z]{1}$/)
        # Standard NIF
        nif[8] == "TRWAGMYFPDXBNJZSQVHLCKE"[nif[0..7].to_i % 23]
      else
        # CIF algorithm
        sum = ival(nif[2]) + ival(nif[4]) + ival(nif[6])
        [1,3,5,7].each do |i|
          t = (2*(ival(nif[i]))).to_s
          t1 = ival(t[0])
          t2 = t[1].nil? ? 0 : ival(t[1])
          sum += t1+t2
        end
        sumstr = sum.to_s
        n = 10 - ival(sumstr[sumstr.length-1])

        if nif.match(/^[KLM]{1}/)
          # Special NIFs (as CIFs)
          nif[8] == (64+n).chr
        elsif nif.match(/^[ABCDEFGHJNPQRSUVW]{1}/)
          # CIFs
          nstr = n.to_s
          (ival(nif[8]) == (64+n).chr) || (nif[8] == nstr[nstr.length-1])
        elsif nif.match(/^[XYZ]{1}/)
          # NIE
          niff = nif.gsub("X","0").gsub("Y","1").gsub("Z","2")
          nif[8] == "TRWAGMYFPDXBNJZSQVHLCKE"[niff[0..7].to_i % 23]
        else
          false
        end
      end
    end

    def ival v
      if Gem::Version.new(RUBY_VERSION.dup) >= Gem::Version.new("1.9")
        v.to_i
      else
        v-48
      end
    end
  end
end

ActiveModel::Validations.send(:include, Nifval)
