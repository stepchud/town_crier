class CreateTownCrierMessages < ActiveRecord::Migration
  def change
    create_table :town_crier_messages do |t|
      t.string     :proclamation
      t.string     :medium
      t.references :contact_id
      t.string     :status
      t.text       :formatted_text

      t.timestamps
    end
  end
end
