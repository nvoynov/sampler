# Custom Helper
module Helper

  # @param str [String]
  # @return [String] where all non word and space characters becomes "_"
  def snake_case(str)
    String.new(str).strip
      .gsub(/[^\w\s]/, '')
      .gsub(/\s{1,}/, '_')
  end

  def mkid(str) = snake_case(str).downcase

  # @param text [String] multiline string
  # @paran size [Integer] indentation size
  # @return [String] mulitline string where each line indendet by :size
  def indent(text, size = 2)
    text.lines.map{|l| ?\s * size + l}.join
  end
    
end

Dir.pwd.then{ 
  helper = __FILE__.gsub(_1, '.')
  puts "NOTE! '#{helper}' included"
}
