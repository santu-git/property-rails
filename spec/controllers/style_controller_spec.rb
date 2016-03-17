require 'rails_helper'

describe Admin::StylesController do
  describe 'GET #index' do
    context 'when authenticated as admin' do
      it 'renders the :index template' do
        sign_in create(:admin)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of qualifiers' do
        sign_in create(:admin)
        styles = [create(:style, value:'test1'), create(:style, value:'test2')]
        get :index
        expect(assigns(:styles)).to match_array(styles)    
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
        styles = [create(:style, value:'test1'), create(:style, value:'test2')]
        get :index
        expect(assigns(:styles)).to match_array(styles)    
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
      post :create, style: attributes_for(:style)
      expect(response).to redirect_to admin_styles_path
      expect(flash[:notice]).to eq "Style successfully created"
    end
  end 

  describe 'GET #edit' do
    it 'renders the :edit template' do
      sign_in create(:admin)
      style = create(:style)
      get :edit, id: style[:id]
      expect(response).to render_template :edit      
    end   
    it 'fails to renders the :edit template, not found' do
      sign_in create(:admin)
      expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
    end     
  end

  describe 'PATCH #update' do
    it 'updates a style' do
      sign_in create(:admin)
      style = create(:style)
      patch :update, id: style, style: attributes_for(:style, value:'test2')    
      expect(response).to redirect_to admin_styles_path  
      expect(flash[:notice]).to eq "Style successfully updated"      
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a style' do
      sign_in create(:admin)
      style = create(:style)
      expect{delete :destroy, id: style}.to change(Style, :count).by(-1)
    end
  end

end
