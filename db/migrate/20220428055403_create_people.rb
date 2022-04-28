class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.boolean :is_mutant
      t.string :dna

      t.timestamps
    end
  end
end
