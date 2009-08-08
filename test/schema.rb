ActiveRecord::Schema.define(:version => 0) do 
  create_table :orders, :force => true do |t| 
    t.string :name
    t.string :desc
    t.timestamps
  end

  create_table :tracks, :force => true do |t|
    t.string :content, :default => "" 
    t.references :trackable, :polymorphic => true
    t.string :operator_name, :default => ''
    t.timestamps
  end

  add_index :tracks, :trackable_type
  add_index :tracks, :trackable_id
end
