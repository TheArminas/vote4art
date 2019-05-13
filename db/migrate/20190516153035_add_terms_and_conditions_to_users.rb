class AddTermsAndConditionsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :terms_and_conditions, :boolean, default: false
  end
end
