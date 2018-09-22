require 'rails_helper'

describe ProductParser do
  describe '.build_product' do
    context 'asin is valid' do
      let!(:asin) { 'B002QYW8LW' }

      it 'returns a product' do
        product_built = described_class.build_product(asin)
        expect(product_built.asin).to eq(asin) 
        expect(product_built).to be_kind_of(Product)
      end
    end
  
    context 'asin is invalid' do
      let(:asin) { 'FAKEASIN' }

      it 'returns nil object' do
        expect(described_class.build_product(asin)).to be_nil
      end
    end
  end
end