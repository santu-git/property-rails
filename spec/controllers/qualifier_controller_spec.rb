require 'rails_helper'

describe Admin::QualifiersController do
  describe 'GET #index' do
    context 'when authenticated as admin' do
      it 'renders the :index template' do
        sign_in create(:admin)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of qualifiers' do
        sign_in create(:admin)
        qualifiers = [create(:qualifier, value:'test1'), create(:qualifier, value:'test2')]
        get :index
        expect(assigns(:qualifiers)).to match_array(qualifiers)    
      end
    end
    context 'when authenticated as user' do
      it 'renders the :index template' do
        sign_in create(:user)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of qualifiers' do
        sign_in create(:admin)
        qualifiers = [create(:qualifier, value:'test1'), create(:qualifier, value:'test2')]
        get :index
        expect(assigns(:qualifiers)).to match_array(qualifiers)    
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
    it 'creates a new qualifier' do
      sign_in create(:admin)
      post :create, qualifier: attributes_for(:qualifier)
      expect(response).to redirect_to admin_qualifiers_path
      expect(flash[:notice]).to eq "Qualifier successfully created"
    end
  end 

  describe 'GET #edit' do
    it 'renders the :edit template' do
      sign_in create(:admin)
      qualifier = create(:qualifier)
      get :edit, id: qualifier[:id]
      expect(response).to render_template :edit      
    end   
    it 'fails to renders the :edit template, not found' do
      sign_in create(:admin)
      expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
    end     
  end

  describe 'PATCH #update' do
    it 'updates a qualifier' do
      sign_in create(:admin)
      qualifier = create(:qualifier)
      patch :update, id: qualifier, qualifier: attributes_for(:qualifier, value:'test2')    
      expect(response).to redirect_to admin_qualifiers_path  
      expect(flash[:notice]).to eq "Qualifier successfully updated"      
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a qualifier' do
      sign_in create(:admin)
      qualifier = create(:qualifier)
      expect{delete :destroy, id: qualifier}.to change(Qualifier, :count).by(-1)
    end
  end

end
