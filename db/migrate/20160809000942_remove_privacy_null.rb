class RemovePrivacyNull < ActiveRecord::Migration
  def change
    change_column :goals, :privacy, :boolean, null: true
  end
end
