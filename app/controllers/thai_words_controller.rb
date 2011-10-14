class ThaiWordsController < InheritedResources::Base
  respond_to :html, :xml, :json
  has_scope :page, :default => 1
end