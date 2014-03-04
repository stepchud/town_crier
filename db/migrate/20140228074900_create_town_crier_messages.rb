class CreateTownCrierMessages < ActiveRecord::Migration
  def change
    create_table :town_crier_messages do |t|
      t.string     :status
      t.string     :status_message
      t.string     :medium
      t.references :proclamation
      t.references :contact

      t.timestamps
    end
  end
end
