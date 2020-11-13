class ChangeProductsPriceToFloat < ActiveRecord::Migration[6.0]
  # To generate a migration file do:
  # > rails g migration <name-of-migration>
  def change
    # https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html#method-i-change_column
    change_column :products, :price, :float
  end
end
