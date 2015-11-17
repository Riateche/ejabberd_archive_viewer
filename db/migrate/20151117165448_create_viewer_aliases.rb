class CreateViewerAliases < ActiveRecord::Migration
  def change
    create_table :viewer_aliases do |t|
      t.string :jid
      t.string :alias

      t.timestamps
    end
  end
end
