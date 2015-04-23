class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text     :number
      t.text     :recipient
      t.text     :message
      t.datetime :expected_sent_at
      t.datetime :sent_at
    end
  end
end
