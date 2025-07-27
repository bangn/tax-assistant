# frozen_string_literal: true

require 'rails_helper'

require 'ostruct'

RSpec.describe ReceiptsController, type: :controller do
  let(:user) { User.create!(given_name: 'John', last_name: 'Doe', username: 'johndoe', email: 'john.doe@example.com', uid: '123') }

  before do
    session[:userinfo] = OpenStruct.new(email: user.email)
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @receipts' do
      receipt = user.receipts.create!(seller: 'Test Seller', description: 'Test Description', total_amount: 10.00, date: Date.today, image: fixture_file_upload('test.png', 'image/png'), category: 'deduction')
      get :index
      expect(assigns(:receipts)).to eq([ receipt ])
    end
  end

  describe 'POST #create' do
    let(:valid_params) { { receipt: { seller: 'Test Seller', description: 'Test Description', total_amount: 10.00, date: Date.today, image: fixture_file_upload('test.png', 'image/png'), category: 'deduction' } } }
    let(:invalid_params) { { receipt: { seller: '' } } }

    it 'creates a new receipt with valid params' do
      expect {
        post :create, params: valid_params
      }.to change(Receipt, :count).by(1)
    end

    it 'does not create a new receipt with invalid params' do
      expect {
        post :create, params: invalid_params
      }.to_not change(Receipt, :count)
    end
  end

  describe 'PATCH #update' do
    let(:receipt) { user.receipts.create!(seller: 'Test Seller', description: 'Test Description', total_amount: 10.00, date: Date.today, image: fixture_file_upload('test.png', 'image/png'), category: 'deduction') }
    let(:valid_params) { { id: receipt.id, receipt: { seller: 'New Seller' } } }
    let(:invalid_params) { { id: receipt.id, receipt: { seller: '' } } }

    it 'updates the receipt with valid params' do
      patch :update, params: valid_params
      receipt.reload
      expect(receipt.seller).to eq('New Seller')
    end

    it 'does not update the receipt with invalid params' do
      patch :update, params: invalid_params
      receipt.reload
      expect(receipt.seller).to_not eq('')
    end
  end

  describe 'DELETE #destroy' do
    let!(:receipt) { user.receipts.create!(seller: 'Test Seller', description: 'Test Description', total_amount: 10.00, date: Date.today, image: fixture_file_upload('test.png', 'image/png'), category: 'deduction') }

    it 'deletes the receipt' do
      expect {
        delete :destroy, params: { id: receipt.id }
      }.to change(Receipt, :count).by(-1)
    end
  end
end
