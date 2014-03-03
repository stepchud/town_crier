class CreateTownCrierProclamations < ActiveRecord::Migration
  def change
    create_table :town_crier_proclamations do |t|
      t.string :title
      t.text   :full_text
      t.text   :options

      t.timestamps
    end
  end
end
