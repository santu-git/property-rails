require 'rails_helper'

describe Admin::TypesController do
  describe 'GET #index' do
    context 'when authenticated as admin' do
      it 'renders the :index template' do
        sign_in create(:admin)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of tenures' do
        sign_in create(:admin)
        types = [create(:type, value:'test1'), create(:type, value:'test2')]
        get :index
        expect(assigns(:types)).to match_array(types)    
      end
    end
    context 'when authenticated as user' do
      it 'renders the :index template' do
        sign_in create(:user)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of types' do
        sign_in create(:admin)
        types = [create(:type, value:'test1'), create(:type, value:'test2')]
        get :index
        expect(assigns(:types)).to match_array(types)    
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
    it 'creates a new type' do
      sign_in create(:admin)
      post :create, type: attributes_for(:type)
      expect(response).to redirect_to admin_types_path
      expect(flash[:notice]).to eq "Type successfully created"
    end
  end 

  describe 'GET #edit' do
    it 'renders the :edit template' do
      sign_in create(:admin)
      type = create(:type)
      get :edit, id: type[:id]
      expect(response).to render_template :edit      
    end   
    it 'fails to renders the :edit template, not found' do
      sign_in create(:admin)
      expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
    end     
  end

  describe 'PATCH #update' do
    it 'updates a type' do
      sign_in create(:admin)
      type = create(:type)
      patch :update, id: type, type: attributes_for(:type, value:'test2')    
      expect(response).to redirect_to admin_types_path  
      expect(flash[:notice]).to eq "Type successfully updated"      
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a type' do
      sign_in create(:admin)
      type = create(:type)
      expect{delete :destroy, id: type}.to change(Type, :count).by(-1)
    end
  end

end
