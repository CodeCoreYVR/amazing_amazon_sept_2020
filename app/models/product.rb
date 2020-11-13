class Product < ApplicationRecord
  # A contant is a value that shouldn't change in our program. It is a hard coded value. 
  # If we ever need change the default price, we can update it here at the top.
  # Anywhere that we use this constant, it will refer to its value.
  # By convention it's SCREAMING_SNAKE_CASE
  DEFAULT_PRICE = 1 

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

  # An object/instance goes through different stages in its lifecycle
  # Callbacks allow us to to do something at a point in the object's life by running a method
  # Examples:
  # 1. Initialzing an object using .new(): after_initialize
  # 2. Creating an object: before_validation, after_validation, before_save, before_create, after_create, after_save
  # 3. Updating an object: before_validation, after_validation, before_save, before_update, after_update, after_save
  # 4. Destroying an object: before_destroy, after_destroy

  # We don't want price to be nil before we go through the validations
  # The lifecycle method takes a symbol named after the method
  # which it will call at that stage of the object's life
  before_validation :set_default_price
  before_save :capitalize_title

  # Create validations using the "validates" method
  # The arguments to the method are: 
  # 1. The column name as a symbol
  # 2. Named arguments that corresponds to the validation and their rules
  # https://guides.rubyonrails.org/active_record_validations.html

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { minimum: 10 }

  private

  # It's best practice to declare our custom callback methods as private, if left public then 
  # it violates object encapsulation principle.
  def set_default_price
    # If you are setting, you must prefix with self. 
    # It's optional to prefix with self if you're just getting.
    # e.g. price -> the instance's price

    self.price ||= DEFAULT_PRICE
  end

  def capitalize_title
    # capitalize! mutates the string it was called on, in this case, the title in the object
    # self.title ||= self.title.capitalize
    self.title.capitalize!
  end
end
