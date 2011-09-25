class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :type
      t.string :word
      t.text :meaning
      t.text :examples
      t.text :reverse_examples
      t.boolean :is_done, :default => false
      t.boolean :is_important, :default => false
      t.integer :frequency, :default => 0

      t.timestamps
    end
  end
end
