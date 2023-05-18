class CreateGists < ActiveRecord::Migration[6.1]
  def change
    create_table :gists do |t|
      t.belongs_to :user,  foreign_key: true, null: false
      t.belongs_to :question,  foreign_key: true, null: false
      t.string :gist_url, null: false

      t.timestamps
    end
  end
end
