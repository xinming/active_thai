class Word < ActiveRecord::Base
  serialize :examples, Hash
  serialize :reverse_examples, Hash
  serialize :meaning, Array
  serialize :similar_words, Hash
  
  require 'open-uri'
  before_create :assign_type
  after_create :assign_details
  
  scope :thai, where(:type => "ThaiWord")
  scope :english, where(:type => "EnglishWord")
  scope :completed, where(:is_done => true)
  scope :to_be_completed, where(:is_done => false)
  
  protected
  def assign_type
    if self.word.match(/[a-zA-Z]+/)
      self.type = "EnglishWord"
    else
      self.type = "ThaiWord"
    end
  end
  
  
  def assign_details
    Word.find(self.id).reset_content.fetch
  end
  
  def reset_content
    self.word.strip!
    self.meaning = Array.new
    self.examples = Hash.new
    self.reverse_examples = Hash.new
    self.similar_words = Hash.new
    self
  end
end
