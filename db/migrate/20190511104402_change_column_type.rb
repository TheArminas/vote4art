class ChangeColumnType < ActiveRecord::Migration[6.0]
  def change
    change_column :pixels, :x, 'integer USING CAST(x AS integer)'
    change_column :pixels, :y, 'integer USING CAST(y AS integer)'
  end
end
