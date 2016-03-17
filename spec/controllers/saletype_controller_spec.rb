require 'rails_helper'

describe Admin::SaleTypesController do
  describe 'GET #index' do
    context 'when authenticated as admin' do
      it 'renders the :index template' do
        sign_in create(:admin)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of sale types' do
        sign_in create(:admin)
        saletypes = [create(:sale_type, value:'test1'), create(:sale_type, value:'test2')]
        get :index
        expect(assigns(:saletypes)).to match_array(saletypes)    
      end
    end
    context 'when authenticated as user' do
      it 'renders the :index template' do
        sign_in create(:user)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of styles' do
        sign_in create(:admin)
        saletypes = [create(:sale_type, value:'test1'), create(:sale_type, value:'test2')]
        get :index
        expect(assigns(:saletypes)).to match_array(saletypes)    
      end      
    end
  end

  describe 'GET #new' do
    context 'when authenticated as admin' do    
      it 'renders the :new template' do
        sign_in create(:admin)
        get :new
        expect(response).to render_template :new
      end
    end
    context 'when authenticated as user' do
      it 'renders the :new template' do
        sign_in create(:user)
        expect{get :new}.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe 'POST #create' do
    it 'creates a new sale type' do
      sign_in create(:admin)
      post :create, sale_type: attributes_for(:sale_type)
      expect(response).to redirect_to admin_sale_types_path
      expect(flash[:notice]).to eq "Sale type successfully created"
    end
  end 

  describe 'GET #edit' do
    it 'renders the :edit template' do
      sign_in create(:admin)
      saletype = create(:sale_type)
      get :edit, id: saletype[:id]
      expect(response).to render_template :edit      
    end   
    it 'fails to renders the :edit template, not found' do
      sign_in create(:admin)
      expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
    end     
  end

  describe 'PATCH #update' do
    it 'updates a sale type' do
      sign_in create(:admin)
      saletype = create(:sale_type)
      patch :update, id: saletype, sale_type: attributes_for(:sale_type, value:'test2')    
      expect(response).to redirect_to admin_sale_types_path  
      expect(flash[:notice]).to eq "Sale type successfully updated"      
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a sale type' do
      sign_in create(:admin)
      saletype = create(:sale_type)
      expect{delete :destroy, id: saletype}.to change(SaleType, :count).by(-1)
    end
  end

end
