require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET new' do
    def send_request
      get :new
    end

    it 'renders :new template' do
      send_request
      expect(response).to render_template(:new)
    end

    it 'loads and assigns all products order desc by date to @products' do
      Product.create(asin: 'a')
      Product.create(asin: 'b')
      Product.create(asin: 'c')

      send_request
      expect(assigns(:products)).to eq(Product.order(created_at: :desc).all)
    end
  end

  describe 'POST create' do
    let(:params) {}

    def send_request
      post :create, params: params
    end

    context 'given a valid ASIN' do
      let(:params) { { asin: 'B002QYW8LW' } }

      it 'redirect to new product page' do
        send_request
        expect(response).to redirect_to(new_product_path)
      end

      it 'notifies user that product was created via flash notice' do
        send_request
        expect(flash[:notice]).to match(/Product created./)
      end

      it 'adds a product in the list' do
        expect {send_request}.to change(Product, :count).by(1)
      end
    end

    context 'given a repeated ASIN' do
      before { Product.create(asin: 'B002QYW8LW') }

      let(:params) { { asin: 'B002QYW8LW' } }

      it 'redirect to new product page' do
        send_request
        expect(response).to redirect_to(new_product_path)
      end

      it 'notifies user that product is already taken via flash notice' do
        send_request
        expect(flash[:error]).to match(/Asin has already been taken/)
      end
    end

    context 'given an invalid ASIN' do
      let(:params) { { asin: 'FAKE-ASIN' } }

      it 'redirect to new product page' do
        send_request
        expect(response).to redirect_to(new_product_path)
      end

      it 'notifies user that ASIN is invalid via flash notice' do
        send_request
        expect(flash[:error]).to match(/Invalid ASIN/)
      end
    end
  end
end
