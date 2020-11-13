class Product < ApplicationRecord
  # To generate a model, run:
  # > rails g model <singular-model-name> <...column-name:column-type...>
  # When running this, a migration is also generated for us under db/migrate
  # to create that product table

  # Rails adds attr_accessors for this class for every column in the 
  # table, so we can get and set values:
  # product_instance.title --> read a value
  # product_instance.title = "A new title" --> set a value

  # We also have class methods such as Product.all which will return 
  # an ActiveRecord Relation of all product instances saved to our db

  # Create validations using the "validates" method
  # The arguments to the method are: 
  # 1. The column name as a symbol
  # 2. Named arguments that corresponds to the validation and their rules
  # https://guides.rubyonrails.org/active_record_validations.html

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 10 }
end
