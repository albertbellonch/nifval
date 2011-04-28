class CreateNifs < ActiveRecord::Migration
  def self.up
    create_table :nifs do |t|
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :nifs
  end
end
