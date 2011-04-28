module Nifval
  class JavascriptGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_javascript
      copy_file 'nifval.js', 'public/javascripts/nifval.js'
    end
  end
end
