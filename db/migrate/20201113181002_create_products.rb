class CreateProducts < ActiveRecord::Migration[6.0]
  # This migration was generated when we generated the Product model
  # Migrations are like a history of db changes
  # Don't change this file if the migration was already run
  # You're safe to modify this file if the migration is still pending

  # To check if the migration is still pending, you can run:
  # > rails db:migrate:status

  # to run all of your pending migrations run:
  # > rails db:migrate

  # To reverse the last migration, do:
  # > rails db:rollback

  def change
    create_table :products do |t|
      # Automtically generates "id" column that 
      # autoincrements for our primary key

      t.string :title # "string" max 255 characters
      t.text :description # "text" is practically unlimited
      t.integer :price

      t.timestamps
      # timestamps is added by default and created the columns of
      # created_at and updated_at which will automatically update for us
    end
  end
end
