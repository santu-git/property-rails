require 'rails_helper'

describe Admin::AvailabilitiesController do
  describe 'GET #index' do
    context 'when authenticated as admin' do
      it 'renders the :index template' do
        sign_in create(:admin)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of availbilities' do
        sign_in create(:admin)
        availabilities = [create(:availability, value:'test1'), create(:availability, value:'test2')]
        get :index
        expect(assigns(:availabilities)).to match_array(availabilities)    
      end
    end
    context 'when authenticated as user' do
      it 'renders the :index template' do
        sign_in create(:user)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of availabilities' do
        sign_in create(:admin)
        availabilities = [create(:availability, value:'test1'), create(:availability, value:'test2')]
        get :index
        expect(assigns(:availabilities)).to match_array(availabilities)    
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
      post :create, availability: attributes_for(:availability)
      expect(response).to redirect_to admin_availabilities_path
      expect(flash[:notice]).to eq "Availability successfully created"
    end
  end 

  describe 'GET #edit' do
    it 'renders the :edit template' do
      sign_in create(:admin)
      availability = create(:availability)
      get :edit, id: availability[:id]
      expect(response).to render_template :edit      
    end   
    it 'fails to renders the :edit template, not found' do
      sign_in create(:admin)
      expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
    end     
  end

  describe 'PATCH #update' do
    it 'updates an availability' do
      sign_in create(:admin)
      availability = create(:availability)
      patch :update, id: availability, availability: attributes_for(:availability, value:'test2')    
      expect(response).to redirect_to admin_availabilities_path  
      expect(flash[:notice]).to eq "Availability successfully updated"      
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes an availability' do
      sign_in create(:admin)
      availability = create(:availability)
      expect{delete :destroy, id: availability}.to change(Availability, :count).by(-1)
    end
  end

end
