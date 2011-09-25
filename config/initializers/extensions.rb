class String
  def clean_up
    self.gsub(/<\/?[^>]*>/, "").gsub(" ; ", "; ").strip
  end
  
  def split_up
    self.split(/[\s]*\;[\s]*/)
  end
end