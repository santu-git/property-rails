require 'rails_helper'

describe Admin::FrequenciesController do
  describe 'GET #index' do
    context 'when authenticated as admin' do
      it 'renders the :index template' do
        sign_in create(:admin)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of frequencies' do
        sign_in create(:admin)
        frequencies = [create(:frequency, value:'test1'), create(:frequency, value:'test2')]
        get :index
        expect(assigns(:frequencies)).to match_array(frequencies)    
      end
    end
    context 'when authenticated as user' do
      it 'renders the :index template' do
        sign_in create(:user)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of frequencies' do
        sign_in create(:admin)
        frequencies = [create(:frequency, value:'test1'), create(:frequency, value:'test2')]
        get :index
        expect(assigns(:frequencies)).to match_array(frequencies)    
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
    it 'creates a new frequency' do
      sign_in create(:admin)
      post :create, frequency: attributes_for(:frequency)
      expect(response).to redirect_to admin_frequencies_path
      expect(flash[:notice]).to eq "Frequency successfully created"
    end
  end 

  describe 'GET #edit' do
    it 'renders the :edit template' do
      sign_in create(:admin)
      frequency = create(:frequency)
      get :edit, id: frequency[:id]
      expect(response).to render_template :edit      
    end   
    it 'fails to renders the :edit template, not found' do
      sign_in create(:admin)
      expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
    end     
  end

  describe 'PATCH #update' do
    it 'updates a frequency' do
      sign_in create(:admin)
      frequency = create(:frequency)
      patch :update, id: frequency, frequency: attributes_for(:frequency, value:'test2')    
      expect(response).to redirect_to admin_frequencies_path  
      expect(flash[:notice]).to eq "Frequency successfully updated"      
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a frequency' do
      sign_in create(:admin)
      frequency = create(:frequency)
      expect{delete :destroy, id: frequency}.to change(Frequency, :count).by(-1)
    end
  end

end
