class AddSimilarToWords < ActiveRecord::Migration
  def change
    add_column :words, :similar_words, :text
    add_column :words, :pronounciation, :string
  end
end
