class AddProductToReview < ActiveRecord::Migration[6.0]
  def change
    # first argument is the table name (plural)
    # second argument is the foreign key (singular)
    add_reference :reviews, :product, foreign_key: true
  end
end
