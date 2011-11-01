class EnglishWord < Word
  def fetch
    doc = open("http://www.thai2english.com/dictionary/#{CGI::escape(self.word)}.html"){ |f| Hpricot(f) }
    (doc/".MainMeaningEng/.thai").each do |meaning_div|
      self.meaning += meaning_div.inner_html.clean_up.gsub(" ", "").split_up
    end
    self.meaning.uniq!

    (doc/"#reverseSearchLoading/.stripeMe").each do |r_div|
      r_word = r_div["word"].clean_up
      r_meaning = (r_div/"table//td").inner_html.clean_up.split_up
      self.reverse_examples[r_word] = r_meaning
    end
    self.save
    self
  end
end