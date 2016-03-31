require 'rails_helper'

describe Admin::QualifiersController do
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
      it 'populates an array of qualifiers' do
        # Sign into site as amin user
        sign_in create(:admin)
        # Create an array of qualifiers
        qualifiers = [create(:qualifier, value:'test1'), create(:qualifier, value:'test2')]
        # Get the index action on this controller
        get :index
        # Expect that the controller assigns the qualifiers variable which should
        # match the array created earlier 
        expect(assigns(:qualifiers)).to match_array(qualifiers)      
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
      it 'populates an array of qualifiers' do
        # Create qualifiers in db
        qualifiers = [create(:qualifier, value:'test1'), create(:qualifier, value:'test2')]
        # Sign into the site as a user
        sign_in create(:user)
        # Get the index action on this controller
        get :index
        # Expect qualifiers variable to match the array of the created qualifiers
        expect(assigns(:qualifiers)).to match_array(qualifiers)    
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
      it 'creates a new qualifier' do
        # Sign into this site as admin
        sign_in create(:admin)
        # Post to create a new qualifier
        post :create, qualifier: attributes_for(:qualifier)
        # Expect to redirect to admin_qualifiers_path
        expect(response).to redirect_to admin_qualifiers_path
        # Expect there to be a flash message
        expect(flash[:notice]).to eq "Qualifier successfully created"
      end
      it 'tries to create an qualifier with existing value' do
        # create an qualifier with value of test
        qualifier = create(:qualifier, value:'test')
        # Sign into site as admin
        sign_in create(:admin)
        # Post to create a new qualifier with the same value as already created
        post :create, qualifier: attributes_for(:qualifier, value: 'test')
        # Expect the response to render the new template
        expect(response).to render_template :new
        # Expect their to be a flash message saying unable to create
        expect(flash[:alert]).to eq "Unable to create qualifier"
      end   
      it 'fails to create qualifier as value is nil' do
        # Sign in to the site as admin
        sign_in create(:admin)
        # Post to create a new qualifier, but sending a nil for value
        post :create, qualifier: attributes_for(:qualifier, value: nil)
        # Expect render of new template
        expect(response).to render_template :new
        # Expect flash message to say unable to create qualifier
        expect(flash[:alert]).to eq "Unable to create qualifier"
      end       
    end
    context 'when authenticated as user' do   
      it 'fails to create a new qualifier' do
        # Sign in as user
        sign_in create(:user)
        # Expect posting to create qualifier fails as not authorized by pundit
        expect{post :create, qualifier: attributes_for(:qualifier)}.to raise_error(Pundit::NotAuthorizedError)
      end
    end    
  end 

  describe 'GET #edit' do
    context 'when authenticated as admin' do                        
      it 'renders the :edit template' do
        # sign in as admin
        sign_in create(:admin)
        # create qualifier
        qualifier = create(:qualifier)
        # Get the edit page
        get :edit, id: qualifier
        # expect view to render with :edit template
        expect(response).to render_template :edit  
      end   
      it 'fails to renders the :edit template, not found' do
        # SIgn in as admin
        sign_in create(:admin)
        # Try to get a non-existant qualifier to edit, should raise an error
        expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound) 
      end  
    end  
    context 'when authenticated as user' do
      it 'fails to render the :edit template as not admin' do
        # Create an qualifier        
        qualifier = create(:qualifier)
        # Login as user
        sign_in create(:user)
        # Expect the attempt to execute the edit action to cause a pundit error
        expect{get :edit, id: qualifier}.to raise_error(Pundit::NotAuthorizedError)
      end
    end      
  end

  describe 'PATCH #update' do
    context 'when authenticated as admin' do                            
      it 'updates a qualifier' do
        # Sign in as admin
        sign_in create(:admin)
        # Create a qualifier
        qualifier = create(:qualifier)
        # Attempt to update his qualifier with a new value
        patch :update, id: qualifier, qualifier: attributes_for(:qualifier, value:'test2')    
        # Expect a redirect to admin_qualifiers_path
        expect(response).to redirect_to admin_qualifiers_path  
        # Expect flash message saying updated
        expect(flash[:notice]).to eq "Qualifier successfully updated"  
      end
      it 'fails to update a qualifier' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an qualifier
        qualifier = create(:qualifier)
        # Attempt to update the qualifier, but setting value to nil
        patch :update, id: qualifier, qualifier: attributes_for(:qualifier, value: nil)   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update qualifier"
      end
      it 'fails to update an qualifier to existing value' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an age
        qualifier1 = create(:qualifier, value: 'test1')
        # Create another age
        qualifier2 = create(:qualifier, value: 'test2')
        # Attempt to update the qualifier, but setting value to an existing value
        patch :update, id: qualifier2, qualifier: attributes_for(:qualifier, value: 'test1')   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update qualifier"
      end       
    end
    context 'when authenticated as user' do                
      it 'fails to update a qualifier' do
        # Create an qualifier
        qualifier = create(:qualifier)
        # Sign in as user
        sign_in create(:user)
        # Attempt to update the qualifier, but raise pundit error as no permission
        expect{patch :update, id: qualifier, qualifier: attributes_for(:qualifier, value:'test2') }.to raise_error(Pundit::NotAuthorizedError)
      end
    end 
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as admin' do                            
      it 'deletes a qualifier' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an qualifier
        qualifier = create(:qualifier)
        # Delete the frequency and expect the number of qualifiers to decrease by 1
        expect{delete :destroy, id: qualifier}.to change(Qualifier, :count).by(-1)  
      end
      it 'does not delete an qualifier, not found' do
        # Sign in as admin
        sign_in create(:admin)
        # Try to delete a non-existing qualifier and expect active record error
        expect{delete :destroy, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
      end       
    end
    context 'when authenticated as user' do
      it 'fails to delete a qualifier' do
        # Create a qualifier
        qualifier = create(:qualifier)
        # Sign in as a user
        sign_in create(:user)
        # Expect delete to fail with pundit authorization error, no permission
        expect{delete :destroy, id: qualifier}.to raise_error(Pundit::NotAuthorizedError)
      end
    end      
  end
end
