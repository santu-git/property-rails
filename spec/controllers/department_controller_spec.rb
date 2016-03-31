require 'rails_helper'

describe Admin::DepartmentsController do
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
      it 'populates an array of departments' do
        # Sign into site as amin user
        sign_in create(:admin)
        # Create an array of departments
        departments = [create(:department, value:'test1'), create(:department, value:'test2')]
        # Get the index action on this controller
        get :index
        # Expect that the controller assigns the departments variable which should
        # match the array created earlier 
        expect(assigns(:departments)).to match_array(departments)    
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
      it 'populates an array of departments' do
        # Create departments in db
        departments = [create(:department, value:'test1'), create(:department, value:'test2')]
        # Sign into the site as a user
        sign_in create(:user)
        # Get the index action on this controller
        get :index
        # Expect departments variable to match the array of the created departments
        expect(assigns(:departments)).to match_array(departments)    
      end      
    end
  end

  describe 'GET #json' do
    it 'returns 2 departments via json' do
      # Create user
      user = create(:user)
      # Sign in user
      sign_in user
      # Create departments
      departments = [create(:department, value:'test1'), create(:department, value: 'test2')]
      # Get json action on controller
      get :json
      # Expect there to be 2 array items in json response
      expect(JSON.parse(response.body).length).to eq 2
    end
    it 'has id key with value of 1 in returned json' do
      # Create user
      user = create(:user)
      # Sign in user
      sign_in user
      # Create a departmnent
      create(:department, id: 1)
      # Get json action on controller
      get :json
      # Expect there to be an id parameter with value 1 on decoded json
      expect(JSON.parse(response.body)[0]).to include('id' => 1)
    end
    it 'has value key with value of test in returned json' do
      # Create user
      user = create(:user)
      # Sign in user
      sign_in user
      # Create department
      create(:department, value: 'test')
      # Call json action on controller
      get :json
      # Expect the decoded json response to include value of test
      expect(JSON.parse(response.body)[0]).to include('value' => 'test')
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
      it 'creates a new department' do
        # Sign into this site as admin
        sign_in create(:admin)
        # Post to create a new department
        post :create, department: attributes_for(:department)
        # Expect to redirect to admin_departments_path
        expect(response).to redirect_to admin_departments_path
        # Expect there to be a flash message
        expect(flash[:notice]).to eq "Department successfully created"
      end
      it 'tries to create an department with existing value' do
        # create an department with value of test
        department = create(:department, value:'test')
        # Sign into site as admin
        sign_in create(:admin)
        # Post to create a new department with the same value as already created
        post :create, department: attributes_for(:department, value: 'test')
        # Expect the response to render the new template
        expect(response).to render_template :new
        # Expect their to be a flash message saying unable to create
        expect(flash[:alert]).to eq "Unable to create department"
      end   
      it 'fails to create department as value is nil' do
        # Sign in to the site as admin
        sign_in create(:admin)
        # Post to create a new department, but sending a nil for value
        post :create, department: attributes_for(:department, value: nil)
        # Expect render of new template
        expect(response).to render_template :new
        # Expect flash message to say unable to create department
        expect(flash[:alert]).to eq "Unable to create department"
      end       
    end
    context 'when authenticated as user' do   
      it 'fails to create a new department' do
        # Sign in as user
        sign_in create(:user)
        # Expect posting to create department fails as not authorized by pundit
        expect{post :create, department: attributes_for(:department)}.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end 

  describe 'GET #edit' do
    context 'when authenticated as admin' do                    
      it 'renders the :edit template' do
        # sign in as admin
        sign_in create(:admin)
        # create department
        department = create(:department)
        # Get the edit page
        get :edit, id: department
        # expect view to render with :edit template
        expect(response).to render_template :edit  
      end   
      it 'fails to renders the :edit template, not found' do
        # SIgn in as admin
        sign_in create(:admin)
        # Try to get a non-existant department to edit, should raise an error
        expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)        
      end  
    end
    context 'when authenticated as user' do
      it 'fails to render the :edit template as not admin' do
        # Create an department        
        department = create(:department)
        # Login as user
        sign_in create(:user)
        # Expect the attempt to execute the edit action to cause a pundit error
        expect{get :edit, id: department}.to raise_error(Pundit::NotAuthorizedError)
      end
    end       
  end

  describe 'PATCH #update' do
    context 'when authenticated as admin' do                        
      it 'updates a department' do
        # Sign in as admin
        sign_in create(:admin)
        # Create a department
        department = create(:department)
        # Attempt to update his department with a new value
        patch :update, id: department, department: attributes_for(:department, value:'test2')    
        # Expect a redirect to admin_availabilities_path
        expect(response).to redirect_to admin_departments_path  
        # Expect flash message saying updated
        expect(flash[:notice]).to eq "Department successfully updated"  
      end
      it 'fails to update an department' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an department
        department = create(:department)
        # Attempt to update the department, but setting value to nil
        patch :update, id: department, department: attributes_for(:department, value: nil)   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update department"
      end
      it 'fails to update an department to existing value' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an age
        department1 = create(:department, value: 'test1')
        # Create another age
        department2 = create(:department, value: 'test2')
        # Attempt to update the department, but setting value to an existing value
        patch :update, id: department2, department: attributes_for(:department, value: 'test1')   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update department"
      end         
    end
    context 'when authenticated as user' do                
      it 'fails to update an availability' do
        # Create an age
        department = create(:department)
        # Sign in as user
        sign_in create(:user)
        # Attempt to update the age, but raise pundit error as no permission
        expect{patch :update, id: department, department: attributes_for(:department, value:'test2') }.to raise_error(Pundit::NotAuthorizedError)
      end
    end    
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as admin' do                        
      it 'deletes a department' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an department
        department = create(:department)
        # Delete the department and expect the number of departments to decrease by 1
        expect{delete :destroy, id: department}.to change(Department, :count).by(-1)   
      end
      it 'does not delete an department, not found' do
        # Sign in as admin
        sign_in create(:admin)
        # Try to delete a non-existing availability and expect active record error
        expect{delete :destroy, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
      end        
    end
    context 'when authenticated as user' do
      it 'fails to delete a department' do
        # Create a department
        department = create(:department)
        # Sign in as a user
        sign_in create(:user)
        # Expect delete to fail with pundit authorization error, no permission
        expect{delete :destroy, id: department}.to raise_error(Pundit::NotAuthorizedError)
      end
    end     
  end
end
