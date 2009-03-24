# mk_links.rb
module TwitterSearch 
  def mk_links line
    new_line = ''
    line.split.each do |word|
      word = case word[0,6]
        when 'http:/', 'https:'
          "link('#{word}', :click => '#{word}'), ' '"
        else
          word[0, 1] == '@' ? ("'@', " + mk_avatar_link(word[1..-1])[0...-5] + ", ' '") : "\"#{word.gsub('"', '\"')} \""
      end
      new_line << word << ', '
    end
    new_line[0...-2]
  end
  
  def mk_avatar_link name
    ", link('#{name}', :click => 'http://twitter.com/#{name}'), ' '"
  end
  
end


