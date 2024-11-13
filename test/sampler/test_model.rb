require_relative '../test_helper'
require 'json'

describe Model do
 it {
   m = File.join(__dir__, 'dummy.json')
     .then{ File.read(_1) }
     .then{ JSON.parse(_1, {symbolize_names: true}) }
     .then{ Assemble.(_1) }
   assert_kind_of OpenStruct, m
   assert_kind_of OpenStruct, m.classes.first
   assert_kind_of OpenStruct, m.classes.first.types.first

   m = Assemble.(a: ?a, b: [1, 2, 3])
   assert_equal 1, m.b.first
 }
end
