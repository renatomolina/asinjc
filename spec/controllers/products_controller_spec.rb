require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:category) { Product.new }

  describe 'GET new' do
    def send_request
      get :new
    end

    it 'loads a new Product' do
      send_request
      expect(assigns(:product)).to be_kind_of(Product)
    end

    it 'renders :new template' do
      send_request
      expect(response).to render_template(:new)
    end
  end

  describe 'GET index' do
    def send_request
      get :index
    end

    it 'loads and assigns all products to @products' do
      send_request
      expect(assigns(:products)).to eq(Product.all)
    end

    it 'renders :index template' do
      send_request
      expect(response).to render_template(:index)
    end
  end

  describe 'POST create' do
    let(:params) {}

    def send_request
      post :create, params: params
    end

    context 'given a valid ASIN' do
      let(:params) { { product: { asin: 'B002QYW8LW' } } }

      it 'redirect to new product page' do
        send_request
        expect(response).to redirect_to(new_product_path)
      end

      it 'notifies user that product was created via flash notice' do
        send_request
        expect(flash[:notice]).to match(/Product was created/i)
      end
    end

    context 'given a invalid ASIN' do
      let(:params) { { product: { asin: 'FAKE-ASIN' } } }

      it 'redirect to new product page' do
        send_request
        expect(response).to redirect_to(new_product_path)
      end

      it 'notifies user that something wrong happened via flash notice' do
        send_request
        expect(flash[:error]).to match(/ASIN invalid/i)
      end
    end
  end
end
