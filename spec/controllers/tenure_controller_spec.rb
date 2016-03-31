require 'rails_helper'

describe Admin::TenuresController do
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
      it 'populates an array of tenures' do
        # Sign into site as amin user
        sign_in create(:admin)
        # Create an array of tenures
        tenures = [create(:tenure, value:'test1'), create(:tenure, value:'test2')]
        # Get the index action on this controller
        get :index
        # Expect that the controller assigns the tenures variable which should
        # match the array created earlier 
        expect(assigns(:tenures)).to match_array(tenures)      
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
      it 'populates an array of tenures' do
        # Create tenures in db
        tenures = [create(:tenure, value:'test1'), create(:tenure, value:'test2')]
        # Sign into the site as a user
        sign_in create(:user)
        # Get the index action on this controller
        get :index
        # Expect tenures variable to match the array of the created tenures
        expect(assigns(:tenures)).to match_array(tenures)    
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
      it 'creates a new tenure' do
        # Sign into this site as admin
        sign_in create(:admin)
        # Post to create a new tenure
        post :create, tenure: attributes_for(:tenure)
        # Expect to redirect to admin_tenures_path
        expect(response).to redirect_to admin_tenures_path
        # Expect there to be a flash message
        expect(flash[:notice]).to eq "Tenure successfully created"
      end
      it 'tries to create an tenure with existing value' do
        # create an tenure with value of test
        tenure = create(:tenure, value:'test')
        # Sign into site as admin
        sign_in create(:admin)
        # Post to create a new tenure with the same value as already created
        post :create, tenure: attributes_for(:tenure, value: 'test')
        # Expect the response to render the new template
        expect(response).to render_template :new
        # Expect their to be a flash message saying unable to create
        expect(flash[:alert]).to eq "Unable to create tenure"
      end   
      it 'fails to create tenure as value is nil' do
        # Sign in to the site as admin
        sign_in create(:admin)
        # Post to create a new tenure, but sending a nil for value
        post :create, tenure: attributes_for(:tenure, value: nil)
        # Expect render of new template
        expect(response).to render_template :new
        # Expect flash message to say unable to create tenure
        expect(flash[:alert]).to eq "Unable to create tenure"
      end       
    end
    context 'when authenticated as user' do   
      it 'fails to create a new tenure' do
        # Sign in as user
        sign_in create(:user)
        # Expect posting to create tenure fails as not authorized by pundit
        expect{post :create, tenure: attributes_for(:tenure)}.to raise_error(Pundit::NotAuthorizedError)
      end
    end    
  end 

  describe 'GET #edit' do
    context 'when authenticated as admin' do                        
      it 'renders the :edit template' do
        # sign in as admin
        sign_in create(:admin)
        # create tenure
        tenure = create(:tenure)
        # Get the edit page
        get :edit, id: tenure
        # expect view to render with :edit template
        expect(response).to render_template :edit  
      end   
      it 'fails to renders the :edit template, not found' do
        # SIgn in as admin
        sign_in create(:admin)
        # Try to get a non-existant tenure to edit, should raise an error
        expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound) 
      end  
    end  
    context 'when authenticated as user' do
      it 'fails to render the :edit template as not admin' do
        # Create an tenure        
        tenure = create(:tenure)
        # Login as user
        sign_in create(:user)
        # Expect the attempt to execute the edit action to cause a pundit error
        expect{get :edit, id: tenure}.to raise_error(Pundit::NotAuthorizedError)
      end
    end      
  end

  describe 'PATCH #update' do
    context 'when authenticated as admin' do                            
      it 'updates a tenure' do
        # Sign in as admin
        sign_in create(:admin)
        # Create a tenure
        tenure = create(:tenure)
        # Attempt to update his tenure with a new value
        patch :update, id: tenure, tenure: attributes_for(:tenure, value:'test2')    
        # Expect a redirect to admin_tenures_path
        expect(response).to redirect_to admin_tenures_path  
        # Expect flash message saying updated
        expect(flash[:notice]).to eq "Tenure successfully updated"  
      end
      it 'fails to update a tenure' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an tenure
        tenure = create(:tenure)
        # Attempt to update the tenure, but setting value to nil
        patch :update, id: tenure, tenure: attributes_for(:tenure, value: nil)   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update tenure"
      end
      it 'fails to update an tenure to existing value' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an age
        tenure1 = create(:tenure, value: 'test1')
        # Create another age
        tenure2 = create(:tenure, value: 'test2')
        # Attempt to update the tenure, but setting value to an existing value
        patch :update, id: tenure2, tenure: attributes_for(:tenure, value: 'test1')   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update tenure"
      end       
    end
    context 'when authenticated as user' do                
      it 'fails to update a tenure' do
        # Create an tenure
        tenure = create(:tenure)
        # Sign in as user
        sign_in create(:user)
        # Attempt to update the tenure, but raise pundit error as no permission
        expect{patch :update, id: tenure, tenure: attributes_for(:tenure, value:'test2') }.to raise_error(Pundit::NotAuthorizedError)
      end
    end 
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as admin' do                            
      it 'deletes a tenure' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an tenure
        tenure = create(:tenure)
        # Delete the frequency and expect the number of tenures to decrease by 1
        expect{delete :destroy, id: tenure}.to change(Tenure, :count).by(-1)  
      end
      it 'does not delete an tenure, not found' do
        # Sign in as admin
        sign_in create(:admin)
        # Try to delete a non-existing tenure and expect active record error
        expect{delete :destroy, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
      end       
    end
    context 'when authenticated as user' do
      it 'fails to delete a tenure' do
        # Create a tenure
        tenure = create(:tenure)
        # Sign in as a user
        sign_in create(:user)
        # Expect delete to fail with pundit authorization error, no permission
        expect{delete :destroy, id: tenure}.to raise_error(Pundit::NotAuthorizedError)
      end
    end      
  end
end
