require 'rails_helper'

describe Admin::TypesController do
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
      it 'populates an array of types' do
        # Sign into site as amin user
        sign_in create(:admin)
        # Create an array of types
        types = [create(:type, value:'test1'), create(:type, value:'test2')]
        # Get the index action on this controller
        get :index
        # Expect that the controller assigns the types variable which should
        # match the array created earlier 
        expect(assigns(:types)).to match_array(types)      
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
      it 'populates an array of types' do
        # Create types in db
        types = [create(:type, value:'test1'), create(:type, value:'test2')]
        # Sign into the site as a user
        sign_in create(:user)
        # Get the index action on this controller
        get :index
        # Expect types variable to match the array of the created types
        expect(assigns(:types)).to match_array(types)    
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
      it 'creates a new type' do
        # Sign into this site as admin
        sign_in create(:admin)
        # Post to create a new type
        post :create, type: attributes_for(:type)
        # Expect to redirect to admin_types_path
        expect(response).to redirect_to admin_types_path
        # Expect there to be a flash message
        expect(flash[:notice]).to eq "Type successfully created"
      end
      it 'tries to create an type with existing value' do
        # create an type with value of test
        type = create(:type, value:'test')
        # Sign into site as admin
        sign_in create(:admin)
        # Post to create a new type with the same value as already created
        post :create, type: attributes_for(:type, value: 'test')
        # Expect the response to render the new template
        expect(response).to render_template :new
        # Expect their to be a flash message saying unable to create
        expect(flash[:alert]).to eq "Unable to create type"
      end   
      it 'fails to create type as value is nil' do
        # Sign in to the site as admin
        sign_in create(:admin)
        # Post to create a new type, but sending a nil for value
        post :create, type: attributes_for(:type, value: nil)
        # Expect render of new template
        expect(response).to render_template :new
        # Expect flash message to say unable to create type
        expect(flash[:alert]).to eq "Unable to create type"
      end       
    end
    context 'when authenticated as user' do   
      it 'fails to create a new type' do
        # Sign in as user
        sign_in create(:user)
        # Expect posting to create type fails as not authorized by pundit
        expect{post :create, type: attributes_for(:type)}.to raise_error(Pundit::NotAuthorizedError)
      end
    end    
  end 

  describe 'GET #edit' do
    context 'when authenticated as admin' do                        
      it 'renders the :edit template' do
        # sign in as admin
        sign_in create(:admin)
        # create type
        type = create(:type)
        # Get the edit page
        get :edit, id: type
        # expect view to render with :edit template
        expect(response).to render_template :edit  
      end   
      it 'fails to renders the :edit template, not found' do
        # SIgn in as admin
        sign_in create(:admin)
        # Try to get a non-existant type to edit, should raise an error
        expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound) 
      end  
    end  
    context 'when authenticated as user' do
      it 'fails to render the :edit template as not admin' do
        # Create an type        
        type = create(:type)
        # Login as user
        sign_in create(:user)
        # Expect the attempt to execute the edit action to cause a pundit error
        expect{get :edit, id: type}.to raise_error(Pundit::NotAuthorizedError)
      end
    end      
  end

  describe 'PATCH #update' do
    context 'when authenticated as admin' do                            
      it 'updates a type' do
        # Sign in as admin
        sign_in create(:admin)
        # Create a type
        type = create(:type)
        # Attempt to update his type with a new value
        patch :update, id: type, type: attributes_for(:type, value:'test2')    
        # Expect a redirect to admin_types_path
        expect(response).to redirect_to admin_types_path  
        # Expect flash message saying updated
        expect(flash[:notice]).to eq "Type successfully updated"  
      end
      it 'fails to update a type' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an type
        type = create(:type)
        # Attempt to update the type, but setting value to nil
        patch :update, id: type, type: attributes_for(:type, value: nil)   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update type"
      end
      it 'fails to update an type to existing value' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an age
        type1 = create(:type, value: 'test1')
        # Create another age
        type2 = create(:type, value: 'test2')
        # Attempt to update the type, but setting value to an existing value
        patch :update, id: type2, type: attributes_for(:type, value: 'test1')   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update type"
      end       
    end
    context 'when authenticated as user' do                
      it 'fails to update a type' do
        # Create an type
        type = create(:type)
        # Sign in as user
        sign_in create(:user)
        # Attempt to update the type, but raise pundit error as no permission
        expect{patch :update, id: type, type: attributes_for(:type, value:'test2') }.to raise_error(Pundit::NotAuthorizedError)
      end
    end 
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as admin' do                            
      it 'deletes a type' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an type
        type = create(:type)
        # Delete the type and expect the number of types to decrease by 1
        expect{delete :destroy, id: type}.to change(Type, :count).by(-1)  
      end
      it 'does not delete an type, not found' do
        # Sign in as admin
        sign_in create(:admin)
        # Try to delete a non-existing type and expect active record error
        expect{delete :destroy, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
      end       
    end
    context 'when authenticated as user' do
      it 'fails to delete a type' do
        # Create a type
        type = create(:type)
        # Sign in as a user
        sign_in create(:user)
        # Expect delete to fail with pundit authorization error, no permission
        expect{delete :destroy, id: type}.to raise_error(Pundit::NotAuthorizedError)
      end
    end      
  end
end
