require 'rails_helper'

describe Admin::MediaTypesController do
  describe 'GET #index' do
    context 'when authenticated as admin' do
      it 'renders the :index template' do
        sign_in create(:admin)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of media types' do
        sign_in create(:admin)
        mediatypes = [create(:media_type, value:'test1'), create(:media_type, value:'test2')]
        get :index
        expect(assigns(:mediatypes)).to match_array(mediatypes)    
      end
    end
    context 'when authenticated as user' do
      it 'renders the :index template' do
        sign_in create(:user)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of media types' do
        sign_in create(:admin)
        mediatypes = [create(:media_type, value:'test1'), create(:media_type, value:'test2')]
        get :index
        expect(assigns(:mediatypes)).to match_array(mediatypes)    
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
    it 'creates a new media type' do
      sign_in create(:admin)
      post :create, media_type: attributes_for(:media_type)
      expect(response).to redirect_to admin_media_types_path
      expect(flash[:notice]).to eq "Media type successfully created"
    end
  end 

  describe 'GET #edit' do
    it 'renders the :edit template' do
      sign_in create(:admin)
      mediatype = create(:media_type)
      get :edit, id: mediatype[:id]
      expect(response).to render_template :edit      
    end   
    it 'fails to renders the :edit template, not found' do
      sign_in create(:admin)
      expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
    end     
  end

  describe 'PATCH #update' do
    it 'updates a media type' do
      sign_in create(:admin)
      mediatype = create(:media_type)
      patch :update, id: mediatype, media_type: attributes_for(:media_type, value:'test2')    
      expect(response).to redirect_to admin_media_types_path  
      expect(flash[:notice]).to eq "Media type successfully updated"      
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a media type' do
      sign_in create(:admin)
      mediatype = create(:media_type)
      expect{delete :destroy, id: mediatype}.to change(MediaType, :count).by(-1)
    end
  end

end
