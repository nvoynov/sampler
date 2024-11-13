require 'erb'

module Sampler

  class Render
    # connect custom helper.rb
    './samples/helper.rb'.then{  
      if File.exist?(_1)
        require _1
        include Helper
      end
    }
    
    # @param erb [String] erb template body
    # @param model [Object] that will be available inside template
    # @param location [Array] @see ERB#location=
    def self.call(erb, model, location = [])
      new.(erb, model, location)
    end

    private_class_method :new

    # @see Render.call
    def call(erb, model, location)
      ERB.new(erb, trim_mode: '%<>')
        .tap{|erb| erb.location = location if location.any? }
        .result(binding)
    end
  end

end
