require 'rails_helper'

# To run tests:
# rspec -f d

RSpec.describe ProductsController, type: :controller do
  def current_user
    @current_user ||= FactoryBot.create(:user)
  end

  describe "#new" do

    # functionally, "context" is the same as "describe", it's just a separate way
    # to branch out our test. USe it to give different contexts (GIVEN) to out tests. 
    context "without a logged in user" do
      it "redirects to the login page" do
        # GIVEN 
        # User not logged in

        # WHEN: Making a GET request to the new action
        # When testing controllers, use methods named after the HTTP verbs
        # e.g. get, post, patch, put, delete 
        # These methods simulate HTTP requests to our controller actions
        # For example, the line below makes a GET to Products#new:
        get :new

        # THEN
        # The "response" object is available inside any controller test.
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with a user logged in" do
      before do
        session[:user_id] = current_user.id
      end

      it "render the new product form" do 
        get :new

        # "render_template" comes with "rails-controller-testing" gem
        expect(response).to render_template(:new)
      end

      it "creates an instance varible of a new product" do 
        get :new

        # assigns(:product) returns the value of the instance variable named
        # after the symbol argument (e.g. :product -> @product)
        # only available with the gem "rails-controller-testing"
        # be_a_new(Product) is a new instance of the Product class
        expect(assigns(:product)).to be_a_new(Product)
      end
    end
  end

  describe "#create" do
    def valid_request
      post(:create, params: { product: FactoryBot.attributes_for(:product)})
    end

    context "without a logged in user" do
      it "redirects to the login page" do 
        valid_request
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with a user logged in" do
      # Use "before" to run a block of code
      # before all tests inside of this context
      before do
        session[:user_id] = current_user.id
      end
      
      context "with valid params" do
        it "assigns an valid product to an instance variable" do
          valid_request
          product = assigns(:product)

          expect(product).to be_a(Product)
          expect(product.valid?).to eq(true)
        end

        it "creates a product and saves it to the database" do
          # GIVEN
          # user logged in, params are valid
          count_before = Product.count

          # WHEN 
          # Making a valid POST request
          valid_request

          count_after = Product.count

          # THEN
          # Expect the count of products to increase by one
          expect(count_before).to eq(count_after - 1)
        end

        it "adds the current user to the product" do 
          valid_request
          product = Product.last

          expect(product.user).to eq(current_user)
        end

        it "redirect to the show page of that product" do
          valid_request
          product = Product.last
          expect(response).to redirect_to(product_path product)
        end
      end

      context "with invalid params" do
        def invalid_request
          post(
            :create, 
            params: { product: FactoryBot.attributes_for(:product, title: nil)}
          )
        end

        it "doesn't create a new product in our db" do
          count_before = Product.count
          invalid_request
          count_after = Product.count

          expect(count_after).to eq(count_before)
        end

        it "renders the new product form" do
          invalid_request

          expect(response).to render_template(:new)
        end

        it "assigns an invalid product to an instance variable" do
          invalid_request
          product = assigns(:product)

          expect(product).to be_a(Product)
          expect(product.valid?).to eq(false)
        end
      end
    end
  end
end
