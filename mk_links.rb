# mk_links.rb
module TwitterSearch 
  def mk_links line
    new_line = ''
    line.split.each do |word|
      word = case word[0,6]
        when 'http:/', 'https:'
          "link('#{word}', :click => '#{word}'), ' '"
        else
          "\"#{word.gsub('"', '\"')} \""
      end
      new_line << word << ', '
    end
    new_line[0...-2]
  end
end


