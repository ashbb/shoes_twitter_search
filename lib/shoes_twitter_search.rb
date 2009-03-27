# shoes_twitter_search.rb
require 'twitter_search'
require 'mk_elements.rb'
require 'google_translate'

W, H, F = 300, 400, 25
T = 'Shoes Twitter Search v0.2'

Shoes.app :width => W, :height => H, :title => T do
  extend TwitterSearch
  terms = ''
  style Link, :underline => nil, :stroke => green
  style LinkHover, :underline => nil, :fill => nil, :stroke => tomato
  
  flow :height => F do
    para "Input: "
    @input = para('Shoes RubyLearning', :weight => 'bold')
    line 0, F, W, F, :stroke => green, :strokewidth => 5
    @star = image :left => W - 25, :top => 0, :width => 20, :height => 20 do
      star 10, 10, 12, 10, 7, :fill => deepskyblue , :stroke => orange
    end
  end
  
  blk = proc do
    twitter_search @input.text do |twitters|
      @f.remove if @f
      @f = flow :width => W, :height => H - F, :left => 0, :top => F, :scroll => true
      twitters.each_with_index do |t, i|
        y = 0
        @f.append do
          f = flow :width => W - 15, :height => 100 do
            background i%2 == 0 ? lavender : cornsilk
            image(t.avatar, :width => 25, :height => 25, :left => 0, :top => 0) rescue error $!
            
            x, y = 26, 3
            x, y = mk_avatar_link(t.screen_name, x, y)

            t.text.split.each do |word|
              x, y = case word[0,6]
                when 'http:/', 'https:'
                  mk_link(word, x, y)
                else
                  if word[0, 1] == '@'
                    para '@', :font => "MS UI Gothic", :size => 10, :left => x, :top => y
                    x += 8
                    mk_avatar_link word[1.. -1], x, y
                  else
                    mk_text word, x, y
                  end
              end
            end
            
            x, y = mk_created_at(t.created_at, x, y)
          end
          f.style :height => y + 30
        end
      end
    end
  end

  keypress do |k|
    case k
      when String
        @input.text += k
      when :backspace
        @input.text = @input.text[0..-2]
      else
    end
  end
  
  @star.click &blk
  every 60, &blk
end
