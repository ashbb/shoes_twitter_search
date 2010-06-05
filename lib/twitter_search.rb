# twitter_search.rb
module TwitterSearch
  require 'hpricot'
  
  Twitter = Struct.new :screen_name, :avatar, :text, :created_at
  PATH = 'http://search.twitter.com/search?q='

  def twitter_search terms
    download PATH + terms.split.join('+') do |dl|
      twitters = []
      doc = Hpricot dl.response.body
      
      (doc/"div.msg").each do |e|
        screen_name, text = e.inner_text.split(': ', 2)
        twitters << Twitter.new(screen_name.strip, '', text.strip.delete("\n"), '')
      end
    
      (doc/"div.avatar").each_with_index do |e, i|
        /src=\"(.*)\"/.match(e.at("img['src']").to_s)
        twitters[i].avatar =  $1
      end
    
      (doc/"div.info").each_with_index do |e, i|
        twitters[i].created_at =  e.inner_text.strip.split("\n").first
      end

      yield twitters
    end
  end  
end


