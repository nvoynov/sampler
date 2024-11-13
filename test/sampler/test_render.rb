require_relative '../test_helper'

describe Render do
  let(:sample) {
    <<~EOF
      name: <%= model.name %>
      type: <%= model.type %>

      The answer to life, the universe, and everything is..
      <%= model.value %>
    EOF
  }
  let(:model) { OpenStruct.new(name: 'foo', type: 'bar', value: 42) }

  it {
    Render.(sample, model)
  }
end
