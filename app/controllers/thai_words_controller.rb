class ThaiWordsController < InheritedResources::Base
  respond_to :html, :xml, :json
  # has_scope :page, :default => 1
  has_scope :completed
  has_scope :to_be_completed
  
  def collection
    end_of_association_chain.order("created_at DESC").page(params[:page] || 1)
  end
  
  
end