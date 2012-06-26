class ThaiWordsController < InheritedResources::Base
  respond_to :html, :xml, :json
  has_scope :to_be_completed
  has_scope :completed
  has_scope :by_frequency
  has_scope :by_random
  
  def collection
    end_of_association_chain.order("created_at DESC").page(params[:page] || 1)
  end

  def audio
    text = CGI.escape(resource.word)
    url = "http://translate.google.com/translate_tts?tl=th&q=#{text}"
    response = open(url,
      {"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.56 Safari/536.5"}).read
    send_data response, :content_type => "audio/mpeg"
  end
  
  
end