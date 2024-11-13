require 'json'
require 'optparse'
require 'fileutils'
include FileUtils

require './lib/sampler'
include Sampler

PARSER = OptionParser.new{|par|
  par.banner = <<~EOF
    JSON ERB Sampler v#{Sampler::VERSION}

    Usage:
      ruby exe/sampler MODEL SAMPLES [OPTIONS]
      
    Examples:
      ruby exe/sampler.rb samples/commands.json samples/commands.c.erb
      ruby exe/sampler.rb samples/commands.json samples/*.erb
      ruby exe/sampler.rb model.json model.*.erb -o output

    Options:
  EOF
  
  par.on('-o', '--output PATH', 'output directory', String)
}

json = ARGV.shift
unless json && ARGV.any?
  puts PARSER
  exit(0)
end
options = {}
PARSER.parse(ARGV, into: options)
dir = options[:output] || 'out'

print 'assembling model.. '
model = File.read(json)
  .then{ JSON.parse(_1, {symbolize_names: true}) }
  .then{ Assemble.(_1) }

puts 'OK'

mkdir_p dir
puts 'renderinig samples.. '
ARGV.each{|sample|
  erb = File.read(sample)
  target = File.join(dir, File.basename(sample, '.erb'))
  print "  #{sample} -> "
  begin
    File.write(target, Render.(erb, model, [sample, 0]))
    puts "#{target}"
  rescue => e
    puts e.full_message
  end
}
puts 'Done!'
