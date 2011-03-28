NifVal
======

Description
-----------

NifVal is a simple gem which adds a Spanish NIF/NIE/CIF validator to
ActiveModel. You simply have to validate ":nif" for "true" for a specific field.

Usage
-----

Let's see an example:

  class Person
    validates :nif, :nif => true

    attr_accessor :nif
  end

Then if we create an instance and see if it is valid, the validation
will be applied.

Let's see one example for each case.
Successful validation:

  p = Person.new("00000000T")
  p.valid? # will return true

Successful validation:

  p = Person.new("A2345678C")
  p.valid? # will return false

Documentation
-------------

Adapted from (http://compartecodigo.com/javascript/validar-nif-cif-nie-segun-ley-vigente-31.html)

You can also find more information on Wikipedia (http://es.wikipedia.org/wiki/N%C3%BAmero_de_identificaci%C3%B3n_fiscal)
