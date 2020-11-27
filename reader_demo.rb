class Product
  attr_reader :title
  def initialize(title)
    @title = title
    print :title.object_id
  end

  # def title
  #   @title
  # end


end

p1 = Product.new "Macbook M1"

print p1.title