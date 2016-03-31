require 'rails_helper'

describe Admin::AvailabilitiesController do
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
      it 'populates an array of availbilities' do
        # Sign into site as amin user
        sign_in create(:admin)
        # Create an array of availabilities
        availabilities = [create(:availability, value:'test1'), create(:availability, value:'test2')]
        # Get the index action on this controller
        get :index
        # Expect that the controller assigns the availabilities variable which should
        # match the array created earlier 
        expect(assigns(:availabilities)).to match_array(availabilities)      
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
      it 'populates an array of availabilities' do
        # Create availabilities in db
        availabilities = [create(:availability, value:'test1'), create(:availability, value:'test2')]
        # Sign into the site as a user
        sign_in create(:user)
        # Get the index action on this controller
        get :index
        # Expect availabilities variable to match the array of the created availabilities
        expect(assigns(:availabilities)).to match_array(availabilities)    
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
      it 'creates a new availability' do
        # Sign into this site as admin
        sign_in create(:admin)
        # Post to create a new availability
        post :create, availability: attributes_for(:availability)
        # Expect to redirect to admin_availabilities_path
        expect(response).to redirect_to admin_availabilities_path
        # Expect there to be a flash message
        expect(flash[:notice]).to eq "Availability successfully created"
      end
      it 'tries to create an availability with existing value' do
        # create an availability with value of test
        availability = create(:availability, value:'test')
        # Sign into site as admin
        sign_in create(:admin)
        # Post to create a new availability with the same value as already created
        post :create, availability: attributes_for(:availability, value: 'test')
        # Expect the response to render the new template
        expect(response).to render_template :new
        # Expect their to be a flash message saying unable to create
        expect(flash[:alert]).to eq "Unable to create availability"
      end   
      it 'fails to create availability as value is nil' do
        # Sign in to the site as admin
        sign_in create(:admin)
        # Post to create a new availability, but sending a nil for value
        post :create, availability: attributes_for(:availability, value: nil)
        # Expect render of new template
        expect(response).to render_template :new
        # Expect flash message to say unable to create availability
        expect(flash[:alert]).to eq "Unable to create availability"
      end         
    end
    context 'when authenticated as user' do   
      it 'fails to create a new availability' do
        # Sign in as user
        sign_in create(:user)
        # Expect posting to create availability fails as not authorized by pundit
        expect{post :create, availability: attributes_for(:availability)}.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end 

  describe 'GET #edit' do
    context 'when authenticated as admin' do                
      it 'renders the :edit template' do
        # sign in as admin
        sign_in create(:admin)
        # create availability
        availability = create(:availability)
        # Get the edit page
        get :edit, id: availability
        # expect view to render with :edit template
        expect(response).to render_template :edit        
      end   
      it 'fails to renders the :edit template, not found' do
        # SIgn in as admin
        sign_in create(:admin)
        # Try to get a non-existant availability to edit, should raise an error
        expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
      end    
    end
    context 'when authenticated as user' do
      it 'fails to render the :edit template as not admin' do
        # Create an availability        
        availability = create(:availability)
        # Login as user
        sign_in create(:user)
        # Expect the attempt to execute the edit action to cause a pundit error
        expect{get :edit, id: availability}.to raise_error(Pundit::NotAuthorizedError)
      end
    end     
  end

  describe 'PATCH #update' do
    context 'when authenticated as admin' do                    
      it 'updates an availability' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an availability
        availability = create(:availability)
        # Attempt to update his availability with a new value
        patch :update, id: availability, availability: attributes_for(:availability, value:'test2')    
        # Expect a redirect to admin_availabilities_path
        expect(response).to redirect_to admin_availabilities_path  
        # Expect flash message saying updated
        expect(flash[:notice]).to eq "Availability successfully updated"      
      end
      it 'fails to update an availability' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an availability
        availability = create(:availability)
        # Attempt to update the availability, but setting value to nil
        patch :update, id: availability, availability: attributes_for(:availability, value: nil)   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update availability"
      end
      it 'fails to update an availability to existing value' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an age
        availability1 = create(:availability, value: 'test1')
        # Create another age
        availability2 = create(:availability, value: 'test2')
        # Attempt to update the age, but setting value to an existing value
        patch :update, id: availability2, availability: attributes_for(:availability, value: 'test1')   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update availability"
      end      
    end
    context 'when authenticated as user' do                
      it 'fails to update an availability' do
        # Create an age
        availability = create(:availability)
        # Sign in as user
        sign_in create(:user)
        # Attempt to update the age, but raise pundit error as no permission
        expect{patch :update, id: availability, availability: attributes_for(:availability, value:'test2') }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as admin' do                    
      it 'deletes an availability' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an availability
        availability = create(:availability)
        # Delete the availability and expect the number of availabilities to decrease by 1
        expect{delete :destroy, id: availability}.to change(Availability, :count).by(-1)        
      end
      it 'does not delete an availability, not found' do
        # Sign in as admin
        sign_in create(:admin)
        # Try to delete a non-existing availability and expect active record error
        expect{delete :destroy, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
      end         
    end
    context 'when authenticated as user' do
      it 'fails to delete an availability' do
        # Create an age
        availability = create(:availability)
        # Sign in as a user
        sign_in create(:user)
        # Expect delete to fail with pundit authorization error, no permission
        expect{delete :destroy, id: availability}.to raise_error(Pundit::NotAuthorizedError)
      end
    end      
  end
end
