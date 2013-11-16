# encoding: utf-8
# Adapted from http://compartecodigo.com/javascript/validar-nif-cif-nie-segun-ley-vigente-31.html

module Nifval
  class Nif
    attr_accessor :nif
    def initialize(nif)
      # Add zeros to the left if needed, and accept lowercase
      @nif = nif.to_s.rjust(9,'0').upcase
    end

    def valid?
      case
      when ! well_formed? then false
      when standard? then valid_standard?
      when special? then valid_special?
      when cif? then valid_cif?
      when nie? then valid_nie?
      else false
      end
    end

    def well_formed?
      nif.match(/\A[A-Z]\d{7}[A-Z0-9]\z/) || nif.match(/\A[0-9]{8}[A-Z]\z/)
    end

    def dni?
      nif.match(/\A[0-9]{8}[A-Z]\z/)
    end
    alias standard? dni?

    def special?
      # According to https://es.wikipedia.org/wiki/C%C3%B3digo_de_identificaci%C3%B3n_fiscal
      # K gets letter, LM get letter or digit
      nif.match(/\AK\d{7}[A-Z]\z/) || nif.match(/\A[LM]\d{7}[0-9A-Z]\z/)
    end

    def cif?
      # According to https://es.wikipedia.org/wiki/C%C3%B3digo_de_identificaci%C3%B3n_fiscal
      # QS get letter, ABEH get digit, other get letter or digit
      nif.match(/\A[QS]\d{7}[A-Z]\z/) ||
      nif.match(/\A[ABEH]\d{8}\z/) ||
      nif.match(/\A[CDFGJNPRUVW]\d{7}[0-9A-Z]\z/)
    end

    def nie?
      nif.match(/\A[XYZ]\d{7}[A-Z]\z/)
    end

    def valid_cif?
      last_char == cif_algorithm_letter || last_char == cif_algorithm_digit
    end

    def valid_nie?
      niff = nif.gsub("X","0").gsub("Y","1").gsub("Z","2")
      last_char == "TRWAGMYFPDXBNJZSQVHLCKE"[niff[0..7].to_i % 23,1]
    end

    def valid_special?
      last_char == cif_algorithm_letter
    end

    def valid_dni?
      last_char == "TRWAGMYFPDXBNJZSQVHLCKE"[nif[0..7].to_i % 23,1]
    end
    alias valid_standard? valid_dni?

    def last_char
      nif[8,1]
    end
    private :last_char

    def cif_algorithm_letter
      %w[J A B C D E F G H I][cif_algorithm_value]
    end
    private :cif_algorithm_letter

    def cif_algorithm_digit
      cif_algorithm_value.to_s
    end
    private :cif_algorithm_digit

    def cif_algorithm_value
      @cif_algorithm_value ||= calculate_cif_algorithm_value
    end
    private :cif_algorithm_value

    def calculate_cif_algorithm_value
      values = nif.split(//).map { |c| c.to_i }
      sum = values[2] + values[4] + values[6]
      [1,3,5,7].each do |i|
        t = 2 * values[i]
        # t - 9 is the same as the sum of digits for t =~ 10..18
        t = t - 9 if t > 9
        sum += t
      end
      (10 - sum % 10) % 10
    end
    private :calculate_cif_algorithm_value
  end
end
