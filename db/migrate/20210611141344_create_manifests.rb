class CreateManifests < ActiveRecord::Migration[5.2]
  def change
    create_table :manifests do |t|
      t.references :passenger, foreign_key: true
      t.references :flight, foreign_key: true

      t.timestamps
    end
  end
end
