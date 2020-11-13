class ChangeProductsPriceToFloat < ActiveRecord::Migration[6.0]
  # To generate a migration file do:
  # > rails g migration <name-of-migration>
  # the name of the migration usually describes what the migration does

  def change
    # https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-change_column
    
    # Use the change_column method to change a column's data type
    # The arguments are (as a symbol):
    # 1. the table name
    # 2. the column name
    # 3. the new data type of the column
    change_column :products, :price, :float
  end
end
