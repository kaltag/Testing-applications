class RenameUserTestTableToTestPassage < ActiveRecord::Migration[6.1]
  def change
    rename_table :user_tests, :test_passages
  end
end
