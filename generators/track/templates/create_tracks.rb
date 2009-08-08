class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :url, :default => "" 
      t.text :content, :default => "" 
      t.references :trackable, :polymorphic => true
      t.references :user
      t.timestamps
    end

    add_index :tracks, :trackable_type
    add_index :tracks, :trackable_id
  end

  def self.down
    drop_table :tracks
  end
end
