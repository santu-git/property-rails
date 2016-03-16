require 'rails_helper'

describe Admin::AgesController do
  describe 'GET #index' do
    context 'when authenticated as admin' do
      it 'renders the :index template' do
        sign_in create(:admin)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of ages' do
        sign_in create(:admin)
        ages = [create(:age, value:'test1'), create(:age, value:'test2')]
        get :index
        expect(assigns(:ages)).to match_array(ages)    
      end
    end
    context 'when authenticated as user' do
      it 'renders the :index template' do
        sign_in create(:user)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of ages' do
        sign_in create(:admin)
        ages = [create(:age, value:'test1'), create(:age, value:'test2')]
        get :index
        expect(assigns(:ages)).to match_array(ages)    
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
    it 'creates a new age' do
      sign_in create(:admin)
      post :create, age: attributes_for(:age)
      expect(response).to redirect_to admin_ages_path
      expect(flash[:notice]).to eq "Age successfully created"
    end
  end 

  describe 'GET #edit' do
    it 'renders the :edit template' do
      sign_in create(:admin)
      age = create(:age)
      get :edit, id: age[:id]
      expect(response).to render_template :edit      
    end   
    it 'fails to renders the :edit template, not found' do
      sign_in create(:admin)
      expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
    end     
  end

  describe 'PATCH #update' do
    it 'updates an age' do
      sign_in create(:admin)
      age = create(:age)
      patch :update, id: age, age: attributes_for(:age, value:'test2')    
      expect(response).to redirect_to admin_ages_path  
      expect(flash[:notice]).to eq "Age successfully updated"      
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes an age' do
      sign_in create(:admin)
      age = create(:age)
      expect{delete :destroy, id: age}.to change(Age, :count).by(-1)
    end
  end

end
