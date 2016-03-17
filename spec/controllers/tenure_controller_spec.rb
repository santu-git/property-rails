require 'rails_helper'

describe Admin::TenuresController do
  describe 'GET #index' do
    context 'when authenticated as admin' do
      it 'renders the :index template' do
        sign_in create(:admin)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of tenures' do
        sign_in create(:admin)
        tenures = [create(:tenure, value:'test1'), create(:tenure, value:'test2')]
        get :index
        expect(assigns(:tenures)).to match_array(tenures)    
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
        tenures = [create(:tenure, value:'test1'), create(:tenure, value:'test2')]
        get :index
        expect(assigns(:tenures)).to match_array(tenures)    
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
    it 'creates a new tenure' do
      sign_in create(:admin)
      post :create, tenure: attributes_for(:tenure)
      expect(response).to redirect_to admin_tenures_path
      expect(flash[:notice]).to eq "Tenure successfully created"
    end
  end 

  describe 'GET #edit' do
    it 'renders the :edit template' do
      sign_in create(:admin)
      tenure = create(:tenure)
      get :edit, id: tenure[:id]
      expect(response).to render_template :edit      
    end   
    it 'fails to renders the :edit template, not found' do
      sign_in create(:admin)
      expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
    end     
  end

  describe 'PATCH #update' do
    it 'updates a tenure' do
      sign_in create(:admin)
      tenure = create(:tenure)
      patch :update, id: tenure, tenure: attributes_for(:tenure, value:'test2')    
      expect(response).to redirect_to admin_tenures_path  
      expect(flash[:notice]).to eq "Tenure successfully updated"      
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a tenure' do
      sign_in create(:admin)
      tenure = create(:tenure)
      expect{delete :destroy, id: tenure}.to change(Tenure, :count).by(-1)
    end
  end

end
