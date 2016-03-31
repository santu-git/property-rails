require 'rails_helper'

describe Admin::AgesController do

  # create admin and standard users
  let(:admin){create(:admin)}
  let(:user){create(:user)}

  describe 'GET #index' do
    
    # create ages array
    let(:ages){[create(:age, value:'test1'), create(:age, value:'test2')]}

    context 'when authenticated as admin' do
      it 'renders the :index template' do
        # Sign in to site as admin user
        sign_in admin
        # Get the index action on this controller
        get :index
        # Expect the response to render the index template
        expect(response).to render_template :index
      end
      it 'populates an array of ages' do
        # Sign into site as amin user
        sign_in admin
        # Get the index action on this controller
        get :index
        # Expect that the controller assigns the ages variable which should
        # match the array created earlier 
        expect(assigns(:ages)).to match_array(ages)    
      end
    end
    context 'when authenticated as user' do
      it 'renders the :index template' do
        # Sign into the site as user
        sign_in user
        # Get the index action on the controller
        get :index
        # Check that that response renders the index template
        expect(response).to render_template :index
      end
      it 'populates an array of ages' do
        # Sign into the site as a user
        sign_in user
        # Get the index action on this controller
        get :index
        # Expect ages variable to match the array of the created ages
        expect(assigns(:ages)).to match_array(ages)    
      end      
    end
  end

  describe 'GET #new' do
    context 'when authenticated as admin' do    
      it 'renders the :new template' do
        # Sign into the site as admin
        sign_in admin
        # Get the new action on this controller
        get :new
        # Expect this to render the new template
        expect(response).to render_template :new
      end
    end
    context 'when authenticated as user' do
      it 'renders the :new template' do
        # Sign into the site as a user
        sign_in user
        # Expect due to pundit authorization this to fail 
        expect{get :new}.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe 'POST #create' do
    context 'when authenticated as admin' do        
      it 'creates a new age' do
        # Sign into this site as admin
        sign_in admin
        # Post to create a new age
        post :create, age: attributes_for(:age)
        # Expect to redirect to admin_ages_path
        expect(response).to redirect_to admin_ages_path
        # Expect there to be a flash message
        expect(flash[:notice]).to eq "Age successfully created"
      end
      it 'tries to create an age with existing value' do
        # create an age with value of test
        age = create(:age, value:'test')
        # Sign into tsite as admin
        sign_in admin
        # Post to create a new age with the same value as already created
        post :create, age: attributes_for(:age, value: 'test')
        # Expect the response to rende rthe new template
        expect(response).to render_template :new
        # Expect their to be a flash message saying unable to create
        expect(flash[:alert]).to eq "Unable to create age"
      end
      it 'fails to create age as value is nil' do
        # Sign in to the site as admin
        sign_in admin
        # Post to create a new age, but sending a nil for value
        post :create, age: attributes_for(:age, value: nil)
        # Expect render of new template
        expect(response).to render_template :new
        # Expect flash message to say unable to create age
        expect(flash[:alert]).to eq "Unable to create age"
      end
    end
    context 'when authenticated as user' do   
      it 'fails to create a new age' do
        # Sign in as user
        sign_in user
        # Expect posting to create age fails as not authorized by pundit
        expect{post :create, age: attributes_for(:age)}.to raise_error(Pundit::NotAuthorizedError)
      end
    end     
  end 

  describe 'GET #edit' do
    context 'when authenticated as admin' do            
      it 'renders the :edit template' do
        # sign in as admin
        sign_in admin
        # create age
        age = create(:age)
        # Get the edit page
        get :edit, id: age
        # expect view to render with :edit template
        expect(response).to render_template :edit      
      end   
      it 'fails to renders the :edit template, not found' do
        # SIgn in as admin
        sign_in admin
        # Try to get a non-existant age to edit, should raise an error
        expect{get :edit, id: 99999}.to raise_error(ActiveRecord::RecordNotFound)
      end     
    end
    context 'when authenticated as user' do
      it 'fails to render the :edit template as not admin' do
        # Create an age        
        age = create(:age)
        # Login as user
        sign_in user
        # Expect the attempt to execute the edit action to cause a pundit error
        expect{get :edit, id: age}.to raise_error(Pundit::NotAuthorizedError)
      end
    end            
  end

  describe 'PATCH #update' do
    context 'when authenticated as admin' do                
      it 'updates an age successfully' do
        # Sign in as admin
        sign_in admin
        # Create an age
        age = create(:age)
        # Attempt to update his age with a new value
        patch :update, id: age, age: attributes_for(:age, value:'test2')    
        # Expect a redirect to admin_ages_path
        expect(response).to redirect_to admin_ages_path  
        # Expect flash message saying updated
        expect(flash[:notice]).to eq "Age successfully updated"      
      end
      it 'fails to update an age' do
        # Sign in as admin
        sign_in admin
        # Create an age
        age = create(:age)
        # Attempt to update the age, but setting value to nil
        patch :update, id: age, age: attributes_for(:age, value: nil)   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update age"
      end
      it 'fails to update an age to existing value' do
        # Sign in as admin
        sign_in admin
        # Create an age
        age1 = create(:age, value: 'test1')
        # Create another age
        age2 = create(:age, value: 'test2')
        # Attempt to update the age, but setting value to an existing value
        patch :update, id: age2, age: attributes_for(:age, value: 'test1')   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update age"
      end      
    end
    context 'when authenticated as user' do                
      it 'fails to update an age' do
        # Create an age
        age = create(:age)
        # Sign in as user
        sign_in user
        # Attempt to update the age, but raise pundit error as no permission
        expect{patch :update, id: age, age: attributes_for(:age, value:'test2') }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as admin' do                    
      it 'deletes an age' do
        # Sign in as admin
        sign_in admin
        # Create an age
        age = create(:age)
        # Delete the age and expect the number of ages to decrease by 1
        expect{delete :destroy, id: age}.to change(Age, :count).by(-1)
      end
      it 'does not delete an age, not found' do
        # Sign in as admin
        sign_in admin
        # Try to delete a non-existing age and expect active record error
        expect{delete :destroy, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
      end    
    end
    context 'when authenticated as user' do
      it 'fails to delete an age' do
        # Create an age
        age = create(:age)
        # Sign in as a user
        sign_in user
        # Expect delete to fail with pundit authorization error, no permission
        expect{delete :destroy, id: age}.to raise_error(Pundit::NotAuthorizedError)
      end
    end                    
  end

end
