# mk_elements.rb

module TwitterSearch
  def mk_text word, x, y
    len = 8 * word.length
    (x = 0; y += 20) if (x + len) > width - 16
    nofill
    nostroke
    r = rect x, y+5, len, 15, :curve => 3
    para code(word), :font => "MS UI Gothic", :size => 10, :left => x, :top => y
    x += (len + 8)
              
    r.click do
      result = search(word)
      h = 8 * result.length / 160 + 1
      b, l, t = self.mouse
      @msg = flow :left => l, :top => t, :width => 160, :height => 20 * h do
        nostroke
        rect 0, 0, 160, 20 * h, :fill => rgb(255, 99, 71, 0.5), :curve => 5
        para result, :font => "MS UI Gothic", :size => 10, :weight => 'bold'
      end
    end
    r.leave{@msg.remove if @msg}
    
    return x, y
  end

  def mk_link word, x, y
    len = 7 * word.length
    (x = 0; y += 20) if (x + len) > width - 16
    short = len > 240 ? word[0, 30] + ' ..' : word
    para link(short, :click => word), :font => "MS UI Gothic", :size => 10, :left => x, :top => y
    x += 7 * short.length
    return x, y
  end
  
  def mk_avatar_link word, x, y
    para link(word, :click => 'http://twitter.com/' + word),
          :font => "MS UI Gothic", :size => 10, :left => x, :top => y
    x += 7 * word.length
    return x, y
  end
  
  def mk_created_at word, x, y
    len = 8 * word.length
    (x = 0; y += 20) if (x + len) > width - 16
    para word, :font => "MS UI Gothic", :size => 10, :left => x, :top => y
    x += 8 * word.length
    return x, y
  end
end
