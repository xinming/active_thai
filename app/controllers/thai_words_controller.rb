class ThaiWordsController < InheritedResources::Base
  respond_to :html, :xml, :json
  has_scope :page, :default => 1
  has_scope :completed
  has_scope :to_be_completed
end