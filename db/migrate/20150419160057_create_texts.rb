class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text     :name
      t.text     :number
      t.text     :recipient
      t.text     :message
      t.text     :date_time

    end
  end
end
