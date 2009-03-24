# shoes_twitter_search.rb
require 'twitter_search'
require 'mk_links'

W, H, F = 300, 400, 25
T = 'Shoes Twitter Search v0.1'

Shoes.app :width => W, :height => H, :title => T do
  extend TwitterSearch
  terms = ''
  style Link, :underline => nil
  style LinkHover, :underline => nil
  
  flow :height => F do
    para "Input: "
    @input = para('Shoes RubyLearning', :weight => 'bold')
    line 0, F, W, F, :stroke => green, :strokewidth => 5
    @star = image :left => W - 25, :top => 0, :width => 20, :height => 20 do
      star 10, 10, 12, 10, 7, :fill => deepskyblue, :stroke => orange
    end
  end

  blk = proc do
    twitter_search @input.text do |twitters|
      @f.remove if @f
      @f = flow :width => W, :height => H - F, :left => 0, :top => F, :scroll => true
      twitters.each_with_index do |t, i|
        @f.append do
          flow do
            background i%2 == 0 ? lavender : cornsilk
            image(t.avatar, :width => 25, :height => 25, :left => 0, :top => 0) rescue error $!
            cmd = 'para "     "' + mk_avatar_link(t.screen_name) +
                       mk_links(t.text) + ', "#{t.created_at}"' +
                      ', :font => "MS UI Gothic", :size => "x-small", :width => W - 20'
            cmd = cmd.gsub(', ,', ',')
            eval cmd
          end
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
