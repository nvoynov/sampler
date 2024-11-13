require 'ostruct'

module Sampler

  Model = OpenStruct

  # Assemble OpenStruct from Hash of Object, Hash, and Array values
  module Assemble
    extend self

    # @param hash [Hash]
    # @return [OpenStruct]
    def call(hash)
      build(hash)
    end

    protected

    def build(hash)
      hash.each{|k, v|
        hash[k] =
          case v
          when Hash
            build(v)
          when Array
            v.any? && v.first.is_a?(Hash) ? v.map{ build(_1) } : v
          else
            v
          end
      }
      OpenStruct.new(hash)
    end
  end

end
