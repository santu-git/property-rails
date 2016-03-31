require 'rails_helper'

describe Admin::StylesController do
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
      it 'populates an array of styles' do
        # Sign into site as amin user
        sign_in create(:admin)
        # Create an array of styles
        styles = [create(:style, value:'test1'), create(:style, value:'test2')]
        # Get the index action on this controller
        get :index
        # Expect that the controller assigns the styles variable which should
        # match the array created earlier 
        expect(assigns(:styles)).to match_array(styles)      
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
      it 'populates an array of styles' do
        # Create styles in db
        styles = [create(:style, value:'test1'), create(:style, value:'test2')]
        # Sign into the site as a user
        sign_in create(:user)
        # Get the index action on this controller
        get :index
        # Expect styles variable to match the array of the created styles
        expect(assigns(:styles)).to match_array(styles)    
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
      it 'creates a new style' do
        # Sign into this site as admin
        sign_in create(:admin)
        # Post to create a new style
        post :create, style: attributes_for(:style)
        # Expect to redirect to admin_styles_path
        expect(response).to redirect_to admin_styles_path
        # Expect there to be a flash message
        expect(flash[:notice]).to eq "Style successfully created"
      end
      it 'tries to create an style with existing value' do
        # create an style with value of test
        style = create(:style, value:'test')
        # Sign into site as admin
        sign_in create(:admin)
        # Post to create a new style with the same value as already created
        post :create, style: attributes_for(:style, value: 'test')
        # Expect the response to render the new template
        expect(response).to render_template :new
        # Expect their to be a flash message saying unable to create
        expect(flash[:alert]).to eq "Unable to create style"
      end   
      it 'fails to create style as value is nil' do
        # Sign in to the site as admin
        sign_in create(:admin)
        # Post to create a new style, but sending a nil for value
        post :create, style: attributes_for(:style, value: nil)
        # Expect render of new template
        expect(response).to render_template :new
        # Expect flash message to say unable to create style
        expect(flash[:alert]).to eq "Unable to create style"
      end       
    end
    context 'when authenticated as user' do   
      it 'fails to create a new style' do
        # Sign in as user
        sign_in create(:user)
        # Expect posting to create style fails as not authorized by pundit
        expect{post :create, style: attributes_for(:style)}.to raise_error(Pundit::NotAuthorizedError)
      end
    end    
  end 

  describe 'GET #edit' do
    context 'when authenticated as admin' do                        
      it 'renders the :edit template' do
        # sign in as admin
        sign_in create(:admin)
        # create style
        style = create(:style)
        # Get the edit page
        get :edit, id: style
        # expect view to render with :edit template
        expect(response).to render_template :edit  
      end   
      it 'fails to renders the :edit template, not found' do
        # SIgn in as admin
        sign_in create(:admin)
        # Try to get a non-existant style to edit, should raise an error
        expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound) 
      end  
    end  
    context 'when authenticated as user' do
      it 'fails to render the :edit template as not admin' do
        # Create an style        
        style = create(:style)
        # Login as user
        sign_in create(:user)
        # Expect the attempt to execute the edit action to cause a pundit error
        expect{get :edit, id: style}.to raise_error(Pundit::NotAuthorizedError)
      end
    end      
  end

  describe 'PATCH #update' do
    context 'when authenticated as admin' do                            
      it 'updates a style' do
        # Sign in as admin
        sign_in create(:admin)
        # Create a style
        style = create(:style)
        # Attempt to update his style with a new value
        patch :update, id: style, style: attributes_for(:style, value:'test2')    
        # Expect a redirect to admin_styles_path
        expect(response).to redirect_to admin_styles_path  
        # Expect flash message saying updated
        expect(flash[:notice]).to eq "Style successfully updated"  
      end
      it 'fails to update a style' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an style
        style = create(:style)
        # Attempt to update the style, but setting value to nil
        patch :update, id: style, style: attributes_for(:style, value: nil)   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update style"
      end
      it 'fails to update an style to existing value' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an age
        style1 = create(:style, value: 'test1')
        # Create another age
        style2 = create(:style, value: 'test2')
        # Attempt to update the style, but setting value to an existing value
        patch :update, id: style2, style: attributes_for(:style, value: 'test1')   
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash alert unable to update
        expect(flash[:alert]).to eq "Unable to update style"
      end       
    end
    context 'when authenticated as user' do                
      it 'fails to update a style' do
        # Create an style
        style = create(:style)
        # Sign in as user
        sign_in create(:user)
        # Attempt to update the style, but raise pundit error as no permission
        expect{patch :update, id: style, style: attributes_for(:style, value:'test2') }.to raise_error(Pundit::NotAuthorizedError)
      end
    end 
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as admin' do                            
      it 'deletes a style' do
        # Sign in as admin
        sign_in create(:admin)
        # Create an style
        style = create(:style)
        # Delete the frequency and expect the number of styles to decrease by 1
        expect{delete :destroy, id: style}.to change(Style, :count).by(-1)  
      end
      it 'does not delete an style, not found' do
        # Sign in as admin
        sign_in create(:admin)
        # Try to delete a non-existing style and expect active record error
        expect{delete :destroy, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
      end       
    end
    context 'when authenticated as user' do
      it 'fails to delete a style' do
        # Create a style
        style = create(:style)
        # Sign in as a user
        sign_in create(:user)
        # Expect delete to fail with pundit authorization error, no permission
        expect{delete :destroy, id: style}.to raise_error(Pundit::NotAuthorizedError)
      end
    end      
  end  
end
