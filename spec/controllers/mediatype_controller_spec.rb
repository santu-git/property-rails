require 'rails_helper'

describe Admin::MediaTypesController do
  describe 'GET #index' do
    context 'when authenticated as admin' do
      it 'renders the :index template' do
        # Sign in to site as admin user
        sign_in create(:admin)
        # Get the index action on this controller
        get :index
        # Expect the response to render the index template
        expect(response).to render_template :index        
      end
      it 'populates an array of mediatypes' do
        # Sign into site as amin user
        sign_in create(:admin)
        # Create an array of mediatypes
        mediatypes = [create(:media_type, value:'test1'), create(:media_type, value:'test2')]
        # Get the index action on this controller
        get :index
        # Expect that the controller assigns the mediatypes variable which should
        # match the array created earlier 
        expect(assigns(:mediatypes)).to match_array(mediatypes)    
      end
    end
    context 'when authenticated as user' do
      it 'renders the :index template' do
        # Sign into the site as user
        sign_in create(:user)
        # Get the index action on the controller
        get :index
        # Check that that response renders the index template
        expect(response).to render_template :index        
      end
      it 'populates an array of mediatypes' do
        # Create mediatypes in db
        mediatypes = [create(:media_type, value:'test1'), create(:media_type, value:'test2')]
        # Sign into the site as a user
        sign_in create(:user)
        # Get the index action on this controller
        get :index
        # Expect mediatypes variable to match the array of the created mediatypes
        expect(assigns(:mediatypes)).to match_array(mediatypes)    
      end      
    end
  end

  describe 'GET #new' do
    context 'when authenticated as admin' do    
      it 'renders the :new template' do
        # Sign into the site as admin
        sign_in create(:admin)
        # Get the new action on this controller
        get :new
        # Expect this to render the new template
        expect(response).to render_template :new 
      end
    end
    context 'when authenticated as user' do
      it 'renders the :new template' do
        # Sign into the site as a user
        sign_in create(:user)
        # Expect due to pundit authorization this to fail 
        expect{get :new}.to raise_error(Pundit::NotAuthorizedError)        
      end
    end
  end

  describe 'POST #create' do
    context 'when authenticated as admin' do                
      it 'creates a new media type' do
        # Sign into this site as admin
        sign_in create(:admin)
        # Post to create a new media_type
        post :create, media_type: attributes_for(:media_type)
        # Expect to redirect to admin_mediatypes_path
        expect(response).to redirect_to admin_media_types_path
        # Expect there to be a flash message
        expect(flash[:notice]).to eq "Media type successfully created"
      end
      it 'tries to create an media type with existing value' do
        # create an media_type with value of test
        media_type = create(:media_type, value:'test')
        # Sign into site as admin
        sign_in create(:admin)
        # Post to create a new media_type with the same value as already created
        post :create, media_type: attributes_for(:media_type, value: 'test')
        # Expect the response to render the new template
        expect(response).to render_template :new
        # Expect their to be a flash message saying unable to create
        expect(flash[:alert]).to eq "Unable to create media type"
      end   
      it 'fails to create media_type as value is nil' do
        # Sign in to the site as admin
        sign_in create(:admin)
        # Post to create a new media_type, but sending a nil for value
        post :create, media_type: attributes_for(:media_type, value: nil)
        # Expect render of new template
        expect(response).to render_template :new
        # Expect flash message to say unable to create media_type
        expect(flash[:alert]).to eq "Unable to create media type"
      end       
    end
    context 'when authenticated as user' do   
      it 'fails to create a new media type' do
        # Sign in as user
        sign_in create(:user)
        # Expect posting to create media_type fails as not authorized by pundit
        expect{post :create, media_type: attributes_for(:media_type)}.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end 

  describe 'GET #edit' do
    context 'when authenticated as admin' do                    
      it 'renders the :edit template' do
        # sign in as admin
        sign_in create(:admin)
        # create media_type
        media_type = create(:media_type)
        # Get the edit page
        get :edit, id: media_type
        # expect view to render with :edit template
        expect(response).to render_template :edit  
      end   
      it 'fails to renders the :edit template, not found' do
        # SIgn in as admin
        sign_in create(:admin)
        # Try to get a non-existant media_type to edit, should raise an error
        expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)        
      end  
    end
    context 'when authenticated as user' do
      it 'fails to render the :edit template as not admin' do
        # Create an media_type        
        media_type = create(:media_type)
        # Login as user
        sign_in create(:user)
        # Expect the attempt to execute the edit action to cause a pundit error
        expect{get :edit, id: media_type}.to raise_error(Pundit::NotAuthorizedError)
      end
    end       
  end

  describe 'PATCH #update' do
    context 'when authenticated as admin' do                        
      it 'updates a media_type' do
        # Sign in as admin
        sign_in create(:admin)
        # Create a media_type
        media_type = create(:media_type)
        # Attempt to update his media_type with a new value
        patch :update, id: media_type, media_type: attributes_for(:media_type, value:'test2')    
        # Expect a redirect to admin_media_types_path
        expect(response).to redirect_to admin_media_types_path  
        # Expect flash message saying updated
        expect(flash[:notice]).to eq "Media type successfully updated"  
      end
      it 'fails to update an media type' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an media type
        media_type = create(:media_type)
        # Attempt to update the media_type, but setting value to nil
        patch :update, id: media_type, media_type: attributes_for(:media_type, value: nil)   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update media type"
      end
      it 'fails to update an media type to existing value' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an age
        media_type1 = create(:media_type, value: 'test1')
        # Create another age
        media_type2 = create(:media_type, value: 'test2')
        # Attempt to update the media type, but setting value to an existing value
        patch :update, id: media_type2, media_type: attributes_for(:media_type, value: 'test1')   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update media type"
      end         
    end
    context 'when authenticated as user' do                
      it 'fails to update an availability' do
        # Create an age
        media_type = create(:media_type)
        # Sign in as user
        sign_in create(:user)
        # Attempt to update the age, but raise pundit error as no permission
        expect{patch :update, id: media_type, media_type: attributes_for(:media_type, value:'test2') }.to raise_error(Pundit::NotAuthorizedError)
      end
    end    
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as admin' do                        
      it 'deletes a media type' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an media_type
        media_type = create(:media_type)
        # Delete the media type and expect the number of mediatypes to decrease by 1
        expect{delete :destroy, id: media_type}.to change(MediaType, :count).by(-1)   
      end
      it 'does not delete an media type, not found' do
        # Sign in as admin
        sign_in create(:admin)
        # Try to delete a non-existing availability and expect active record error
        expect{delete :destroy, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
      end        
    end
    context 'when authenticated as user' do
      it 'fails to delete a media type' do
        # Create a media_type
        media_type = create(:media_type)
        # Sign in as a user
        sign_in create(:user)
        # Expect delete to fail with pundit authorization error, no permission
        expect{delete :destroy, id: media_type}.to raise_error(Pundit::NotAuthorizedError)
      end
    end     
  end
end
