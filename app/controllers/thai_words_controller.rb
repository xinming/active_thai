class ThaiWordsController < InheritedResources::Base
  respond_to :html, :xml, :json
  def collection
    end_of_association_chain.order("created_at DESC").page(params[:page] || 1)
  end
end