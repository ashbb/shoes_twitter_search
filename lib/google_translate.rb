# google_translate.rb
module TwitterSearch
  def search word
    require 'open-uri'

    path = "http://ajax.googleapis.com/ajax/services/language/" \
           "translate?v=1.0&langpair=en%7C"
    q = "&q="

    word = 'unknown' if word.empty?
    lang = 'ja'
    result = open(path + lang + q + word).read.split('"')[5]
    result =  search word[0...-1] if result.empty?
    return word + ': ' + result
  end
end