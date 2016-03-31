require 'rails_helper'

describe Admin::FrequenciesController do
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
      it 'populates an array of frequencies' do
        # Sign into site as amin user
        sign_in create(:admin)
        # Create an array of frequencies
        frequencies = [create(:frequency, value:'test1'), create(:frequency, value:'test2')]
        # Get the index action on this controller
        get :index
        # Expect that the controller assigns the frequencies variable which should
        # match the array created earlier 
        expect(assigns(:frequencies)).to match_array(frequencies)    
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
      it 'populates an array of frequencies' do
        # Create frequencies in db
        frequencies = [create(:frequency, value:'test1'), create(:frequency, value:'test2')]
        # Sign into the site as a user
        sign_in create(:user)
        # Get the index action on this controller
        get :index
        # Expect frequencies variable to match the array of the created frequencies
        expect(assigns(:frequencies)).to match_array(frequencies)    
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
      it 'creates a new frequency' do
        # Sign into this site as admin
        sign_in create(:admin)
        # Post to create a new frequency
        post :create, frequency: attributes_for(:frequency)
        # Expect to redirect to admin_frequencies_path
        expect(response).to redirect_to admin_frequencies_path
        # Expect there to be a flash message
        expect(flash[:notice]).to eq "Frequency successfully created"
      end
      it 'tries to create an frequency with existing value' do
        # create an frequency with value of test
        frequency = create(:frequency, value:'test')
        # Sign into site as admin
        sign_in create(:admin)
        # Post to create a new frequency with the same value as already created
        post :create, frequency: attributes_for(:frequency, value: 'test')
        # Expect the response to render the new template
        expect(response).to render_template :new
        # Expect their to be a flash message saying unable to create
        expect(flash[:alert]).to eq "Unable to create frequency"
      end   
      it 'fails to create frequency as value is nil' do
        # Sign in to the site as admin
        sign_in create(:admin)
        # Post to create a new frequency, but sending a nil for value
        post :create, frequency: attributes_for(:frequency, value: nil)
        # Expect render of new template
        expect(response).to render_template :new
        # Expect flash message to say unable to create frequency
        expect(flash[:alert]).to eq "Unable to create frequency"
      end       
    end
    context 'when authenticated as user' do   
      it 'fails to create a new frequency' do
        # Sign in as user
        sign_in create(:user)
        # Expect posting to create frequency fails as not authorized by pundit
        expect{post :create, frequency: attributes_for(:frequency)}.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end 

  describe 'GET #edit' do
    context 'when authenticated as admin' do                    
      it 'renders the :edit template' do
        # sign in as admin
        sign_in create(:admin)
        # create frequency
        frequency = create(:frequency)
        # Get the edit page
        get :edit, id: frequency
        # expect view to render with :edit template
        expect(response).to render_template :edit  
      end   
      it 'fails to renders the :edit template, not found' do
        # SIgn in as admin
        sign_in create(:admin)
        # Try to get a non-existant frequency to edit, should raise an error
        expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)        
      end  
    end
    context 'when authenticated as user' do
      it 'fails to render the :edit template as not admin' do
        # Create an frequency        
        frequency = create(:frequency)
        # Login as user
        sign_in create(:user)
        # Expect the attempt to execute the edit action to cause a pundit error
        expect{get :edit, id: frequency}.to raise_error(Pundit::NotAuthorizedError)
      end
    end       
  end

  describe 'PATCH #update' do
    context 'when authenticated as admin' do                        
      it 'updates a frequency' do
        # Sign in as admin
        sign_in create(:admin)
        # Create a frequency
        frequency = create(:frequency)
        # Attempt to update his frequency with a new value
        patch :update, id: frequency, frequency: attributes_for(:frequency, value:'test2')    
        # Expect a redirect to admin_availabilities_path
        expect(response).to redirect_to admin_frequencies_path  
        # Expect flash message saying updated
        expect(flash[:notice]).to eq "Frequency successfully updated"  
      end
      it 'fails to update an frequency' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an frequency
        frequency = create(:frequency)
        # Attempt to update the frequency, but setting value to nil
        patch :update, id: frequency, frequency: attributes_for(:frequency, value: nil)   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update frequency"
      end
      it 'fails to update an frequency to existing value' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an age
        frequency1 = create(:frequency, value: 'test1')
        # Create another age
        frequency2 = create(:frequency, value: 'test2')
        # Attempt to update the frequency, but setting value to an existing value
        patch :update, id: frequency2, frequency: attributes_for(:frequency, value: 'test1')   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update frequency"
      end         
    end
    context 'when authenticated as user' do                
      it 'fails to update an availability' do
        # Create an age
        frequency = create(:frequency)
        # Sign in as user
        sign_in create(:user)
        # Attempt to update the age, but raise pundit error as no permission
        expect{patch :update, id: frequency, frequency: attributes_for(:frequency, value:'test2') }.to raise_error(Pundit::NotAuthorizedError)
      end
    end    
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as admin' do                        
      it 'deletes a frequency' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an frequency
        frequency = create(:frequency)
        # Delete the frequency and expect the number of frequencies to decrease by 1
        expect{delete :destroy, id: frequency}.to change(Frequency, :count).by(-1)   
      end
      it 'does not delete an frequency, not found' do
        # Sign in as admin
        sign_in create(:admin)
        # Try to delete a non-existing availability and expect active record error
        expect{delete :destroy, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
      end        
    end
    context 'when authenticated as user' do
      it 'fails to delete a frequency' do
        # Create a frequency
        frequency = create(:frequency)
        # Sign in as a user
        sign_in create(:user)
        # Expect delete to fail with pundit authorization error, no permission
        expect{delete :destroy, id: frequency}.to raise_error(Pundit::NotAuthorizedError)
      end
    end     
  end
end
