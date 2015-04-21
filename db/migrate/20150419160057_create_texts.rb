class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text     :number
      t.text     :message
    end
  end
end
