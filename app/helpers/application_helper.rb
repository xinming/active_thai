module ApplicationHelper
  # def tts(text, language = "en")
  #   url ="http://translate.google.com/translate_tts?tl=#{language}&q=#{URI.escape(text)}"
  #   data = ActiveSupport::Base64.encode64(open(url) { |io| io.read })
  #   raw "<audio controls=\"controls\" src=\"data:audio/mpeg;base64,#{data}\"></audio>"
  # end
end
