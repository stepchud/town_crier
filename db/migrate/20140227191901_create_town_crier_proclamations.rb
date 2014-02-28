class CreateTownCrierProclamations < ActiveRecord::Migration
  def change
    create_table :town_crier_proclamations do |t|
      t.string :title
      t.text   :data

      t.timestamps
    end
  end
end
