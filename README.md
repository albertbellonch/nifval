NifVal
======

Description
-----------

NifVal provides an API to validate Spanish NIF/NIE/CIF/DNI numbers.  As a shortcut,
it provides an ActiveModel validator. You simply have to validate `:nif` for `true`
for a specific field.

Installation
------------

Simply add this gem to your Gemfile:

    gem "nifval"

If `ActiveModel` has already been loaded when the `nifval` gem is loaded (as is
the case in a Rails app) `nifval` will automatically load the `ActiveModel`
validator.  If you want to force loading of the `ActiveModel` validator, write
this in your Gemfile:

    gem "nifval", :require => 'nifval/activemodel'

and execute <i>bundle</i>.

Note: It appears that if we load <b>NifVal</b> after <b>Devise</b>, <b>Nifval</b> won't work. In order to make everything work, simply add <b>Nifval</b> before <b>Devise</b> in the Gemfile.

In a Rails project, run the generator in order to install the I18n template:

    rails generate nifval:install

If you want to validate a Nif via Javascript, you can also add:

    rails generate nifval:javascript

And you are done!

Usage
-----

### On your model ###

Let's see an example:

    class Person < ActiveRecord::Base
      validates :nif, :nif => true
    end

Then if we create an instance and see if it is valid, the validation
will be checked.

Let's see one example for each case.
A successful validation (correct control digit T for 00000000):

    p = Person.new(nif: "00000000T")
    p.valid? # => true

And an unsuccessful one (mistaken control digit C for A2345678):

    p = Person.new(nif: "A2345678C")
    p.valid? # => false

### Stand-alone validation ###

While the ActiveModel validation only gives you true or false, the stand-alone validator
has a complete API:

    nif = Nifval::Nif.new("00000000T")   # => #<Nifval::Nif:0x007ff0510211a8 @nif="00000000T">
    nif.dni?         # => true
    nif.valid?       # => true
    nif.valid_dni?   # => true
    nif.valid_nie?   # => false
    nif = Nifval::Nif.new("A2345678C")   # => #<Nifval::Nif:0x007ff05186ff30 @nif="A2345678C">
    nif.cif?         # => false
    nif = Nifval::Nif.new("A23456788")   # => #<Nifval::Nif:0x007ff051814e00 @nif="A23456788">
    nif.cif?         # => true
    nif.valid_cif?   # => false

### Via Javascript ###

<i>Please refer to the Installation section on how to get Nifval's Javascript
file.</i>

You only have to add <i>nifval.js</i> to your application layout. Assuming the
use of HAML:

    = javascript_include_tag "nifval"

And then execute the <i>nifval(nifToCheck)</i> function, which returns a
boolean.

    nifval("00000000T") // returns true
    nifval("A2345678C") // returns false

### Example ###

You can see both situations via the test application included in this
gem. This test app is also available at
[http://nifvalapp.heroku.com](http://nifvalapp.heroku.com).

Changelog
---------

- v0.1.0 First version, basic Spanish NIF validation.
- v0.1.1 Some fixes on regexps taht would allow invalid NIFs.
- v0.1.2 Compatible with Ruby 1.8.7 and 1.9.2.
- v0.1.3 Adding I18n support for error messages.
- v0.1.4 Several fixes.
- v0.2.0 Added test app, and providing a Javascript version too.
- v0.2.1 Accepting strings with smaller than 9 chars.
- v0.2.2 Core refactor, thanks to @ritxi.
- v0.3.0 Calls to methods with `?` like `#dni?` now return false or true.

Contributors
------------

Thanks to @ritxi for the refactoring in v0.2.2.

Documentation
-------------

Adapted from [here](http://compartecodigo.com/javascript/validar-nif-cif-nie-segun-ley-vigente-31.html).

You can also find more information [on Wikipedia](http://es.wikipedia.org/wiki/N%C3%BAmero_de_identificaci%C3%B3n_fiscal).
