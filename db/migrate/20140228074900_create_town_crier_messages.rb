class CreateTownCrierMessages < ActiveRecord::Migration
  def change
    create_table :town_crier_messages do |t|
      t.string     :status
      t.string     :medium
      t.references :proclamation
      t.references :contact
      t.text       :formatted_text

      t.timestamps
    end
  end
end
