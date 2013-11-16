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
      nstr = cif_algorithm_value.to_s
      (ival(nif[8]) == (64+cif_algorithm_value).chr) || (nif[8] == nstr[nstr.length-1])
    end

    def valid_nie?
      niff = nif.gsub("X","0").gsub("Y","1").gsub("Z","2")
      nif[8] == "TRWAGMYFPDXBNJZSQVHLCKE"[niff[0..7].to_i % 23]
    end

    def valid_special?
      nif[8] == (64+cif_algorithm_value).chr
    end

    def valid_dni?
      nif[8] == "TRWAGMYFPDXBNJZSQVHLCKE"[nif[0..7].to_i % 23]
    end
    alias valid_standard? valid_dni?

    def cif_algorithm_value
      @cif_algorithm_value ||= calculate_cif_algorithm_value
    end
    private :cif_algorithm_value

    def calculate_cif_algorithm_value
      # CIF algorithm
      sum = ival(nif[2]) + ival(nif[4]) + ival(nif[6])
      [1,3,5,7].each do |i|
        t = (2*(ival(nif[i]))).to_s
        t1 = ival(t[0])
        t2 = t[1].nil? ? 0 : ival(t[1])
        sum += t1+t2
      end
      sumstr = sum.to_s

      (10 - ival(sumstr[sumstr.length-1]))
    end
    private :calculate_cif_algorithm_value

    def ival v
      if Gem::Version.new(RUBY_VERSION.dup) >= Gem::Version.new("1.9")
        v.to_i
      else
        v-48
      end
    end
    private :ival
  end
end
