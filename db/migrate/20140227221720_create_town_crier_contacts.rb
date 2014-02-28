class CreateTownCrierContacts < ActiveRecord::Migration
  def change
    create_table :town_crier_contacts do |t|
      t.string  :name
      t.string  :email
      t.string  :cell_number
      t.string  :cell_carrier
      t.boolean :cell_allows_mms
      t.boolean :mobile_push
      t.string  :im
      t.string  :twitter
      t.string  :facebook

      t.timestamps
    end
  end
end
