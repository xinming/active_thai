class ThaiWord < Word
  def fetch
    doc = open("http://www.thai2english.com/search.aspx?q=#{CGI::escape(self.word)}"){ |f| Hpricot(f) }
    (doc/".thaiMeaningLi").each do |meaning_div|
      self.meaning += meaning_div.inner_html.clean_up.split_up
    end
    self.meaning.uniq!
    
    self.pronounciation = (doc/"#dictionaryTransliteration").inner_html.clean_up
    
    (doc/".examplesContainer/.stripeMe").each do |e_div|
      # raise e_div.inspect
      e_word = (e_div/"a.t2e/").to_html.clean_up
      e_meaning = (e_div/".floatedMeanings/ul/li").inner_html.clean_up.split_up
      self.examples[e_word] = e_meaning
    end

    (doc/"#reverseSearchLoading/.lineMeanings").each do |r_div|
      r_word = (r_div/"a.t2e_eng").inner_html.strip
      r_meaning = (r_div/"span.thai").inner_html.clean_up.split_up
      self.reverse_examples[r_word] = r_meaning
    end

    (doc/".soundalikesContainer/.stripeMe").each do |s_div|
      s_word = (s_div/"a.t2e").inner_html.strip
      s_meaning = []
      (s_div/"//.floatedMeanings/ul/li").each do |m|
        s_meaning += m.inner_html.clean_up.split_up
      end
      self.similar_words[s_word] = s_meaning
    end
    self.save
    self
  end
end