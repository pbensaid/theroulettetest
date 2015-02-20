class AddMysecretcodeToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :mysecretcode, :string
  end
end
