require 'rails_helper'

describe Admin::ListingsController do
  context 'when authenticated as user' do                  
    describe 'GET #index' do
      it 'renders the :index template' do
        # sign in user
        sign_in create(:user)
        # get index action
        get :index
        # check response is render of index template
        expect(response).to render_template :index
      end
      it 'populates an array of listings' do
        # Create user
        user = create(:user)
        # Sign into site as user
        sign_in user 
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create department
        department = create(:department, id: 2)
        # Create an array of ages
        listings = [
          create(:letting_listing, branch: branch, department: department),
          create(:letting_listing, branch: branch, department: department)
        ]
        # Get the index action on this controller
        get :index
        # Expect that the controller assigns the ages variable which should
        # match the array created earlier 
        expect(assigns(:listings)).to match_array(listings)    
      end
    end
  end  
  describe 'GET #new' do
    context 'when authenticated as user' do        
      it 'renders the :new template' do
        # sign in user
        sign_in create(:user)
        # get new action
        get :new      
        # expect new template to be rendered
        expect(response).to render_template :new
      end
    end
  end
  describe 'POST #create' do
    context 'when authenticated as user' do                
      it 'creates a new listing' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create age
        age = create(:age)
        # create availability
        availability = create(:availability)
        # create style
        style = create(:style)
        # create type
        type = create(:type)
        # create department
        department = create(:department, id: 2, value: 'Lettings')
        # create frequency
        frequency = create(:frequency)
        # create listing
        post :create, listing: attributes_for(
          :letting_listing, 
          branch_id: branch[:id],
          age_id: age[:id], 
          availability_id: availability[:id],
          style_id: style[:id],
          type_id: type[:id],
          department_id: department[:id],
          frequency_id: frequency[:id]
        )
        # expect response to redirect to admin_assets_path
        expect(response).to redirect_to admin_listings_path
        # expect flash notice to say listing created
        expect(flash[:notice]).to eq "Listing successfully created"
      end
      it 'fails to create new listing availability nil' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create age
        age = create(:age)
        # create style
        style = create(:style)
        # create type
        type = create(:type)
        # create department
        department = create(:department, id: 2, value: 'Lettings')
        # create frequency
        frequency = create(:frequency)
        # create listing
        post :create, listing: attributes_for(
          :letting_listing, 
          branch_id: branch[:id],
          age_id: age[:id], 
          style_id: style[:id],
          type_id: type[:id],
          department_id: department[:id],
          frequency_id: frequency[:id]
        )
        # expect flash notice to say listing created
        expect(flash[:alert]).to eq "Unable to create listing"
        # check response is render of new template
        expect(response).to render_template :new        
      end      
      it 'fails to create listing as branch is nil' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create age
        age = create(:age)
        # create availability
        availability = create(:availability)
        # create style
        style = create(:style)
        # create type
        type = create(:type)
        # create department
        department = create(:department, id: 2, value: 'Lettings')
        # create frequency
        frequency = create(:frequency)
        # Expect due to pundit authorization this to fail 
        expect{post :create, listing: attributes_for(
          :letting_listing, 
          age_id: age[:id], 
          availability_id: availability[:id],
          style_id: style[:id],
          type_id: type[:id],
          department_id: department[:id],
          frequency_id: frequency[:id]
        )}.to raise_error(Pundit::NotAuthorizedError)       
      end  
    end
  end 
  describe 'GET #edit' do
    context 'when authenticated as user' do                    
      it 'renders the :edit template' do
        # sign in as user
        user = create(:user)
        # Sign in as user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create age
        age = create(:age)
        # create availability
        availability = create(:availability)
        # create style
        style = create(:style)
        # create type
        type = create(:type)
        # create department
        department = create(:department, id: 2, value: 'Lettings')
        # create frequency
        frequency = create(:frequency)
        # create listing
        listing = create(
          :letting_listing, 
          branch_id: branch[:id],
          age_id: age[:id], 
          availability_id: availability[:id],
          style_id: style[:id],
          type_id: type[:id],
          department_id: department[:id],
          frequency_id: frequency[:id]
        )
        # Get the edit page
        get :edit, id: listing
        # expect view to render with :edit template
        expect(response).to render_template :edit  
      end   
      it 'fails to renders the :edit template, not found' do
        # SIgn in as user
        sign_in create(:user)
        # Try to get a non-existant frequency to edit, should raise an error
        expect{get :edit, id: 99999}.to raise_error(ActiveRecord::RecordNotFound)        
      end  
    end
  end

  describe 'PATCH #update' do
    context 'when authenticated as user' do                            
      it 'updates a listing' do
        user = create(:user)
        # Sign in as user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create age
        age = create(:age)
        # create availability
        availability = create(:availability)
        # create style
        style = create(:style)
        # create type
        type = create(:type)
        # create department
        department = create(:department, id: 2, value: 'Lettings')
        # create frequency
        frequency = create(:frequency)
        # create listing
        listing = create(
          :letting_listing, 
          branch_id: branch[:id],
          age_id: age[:id], 
          availability_id: availability[:id],
          style_id: style[:id],
          type_id: type[:id],
          department_id: department[:id],
          frequency_id: frequency[:id]
        )
        patch :update, id: listing, listing: attributes_for(
          :letting_listing, 
          branch_id: branch[:id],
          age_id: age[:id], 
          availability_id: availability[:id],
          style_id: style[:id],
          type_id: type[:id],
          department_id: department[:id],
          frequency_id: frequency[:id],
          address_1: 'Testing'
        )
        # expect response to redirect to admin_assets_path
        expect(response).to redirect_to admin_listings_path
        # expect flash notice to say listing updated
        expect(flash[:notice]).to eq "Listing successfully updated"
      end
      it 'fails to update a listing, address_1 nil' do
        user = create(:user)
        # Sign in as user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create age
        age = create(:age)
        # create availability
        availability = create(:availability)
        # create style
        style = create(:style)
        # create type
        type = create(:type)
        # create department
        department = create(:department, id: 2, value: 'Lettings')
        # create frequency
        frequency = create(:frequency)
        # create listing
        listing = create(
          :letting_listing, 
          branch_id: branch[:id],
          age_id: age[:id], 
          availability_id: availability[:id],
          style_id: style[:id],
          type_id: type[:id],
          department_id: department[:id],
          frequency_id: frequency[:id]
        )
        patch :update, id: listing, listing: attributes_for(
          :letting_listing, 
          branch_id: branch[:id],
          age_id: age[:id], 
          availability_id: availability[:id],
          style_id: style[:id],
          type_id: type[:id],
          department_id: department[:id],
          frequency_id: frequency[:id],
          address_1: nil
        )
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash message to say unable to create asset
        expect(flash[:alert]).to eq "Unable to update listing"   
      end      
    end
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as user' do                        
      it 'deletes a listing' do
        user = create(:user)
        # Sign in as user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create age
        age = create(:age)
        # create availability
        availability = create(:availability)
        # create style
        style = create(:style)
        # create type
        type = create(:type)
        # create department
        department = create(:department, id: 2, value: 'Lettings')
        # create frequency
        frequency = create(:frequency)
        # create listing
        listing = create(
          :letting_listing, 
          branch_id: branch[:id],
          age_id: age[:id], 
          availability_id: availability[:id],
          style_id: style[:id],
          type_id: type[:id],
          department_id: department[:id],
          frequency_id: frequency[:id]
        )
        # Delete the listing and expect the number of listing to decrease by 1
        expect{delete :destroy, id: listing}.to change(Listing, :count).by(-1)   
      end
      it 'does not delete an listing, not found' do
        # Sign in as admin
        sign_in create(:admin)
        # Try to delete a non-existing availability and expect active record error
        expect{delete :destroy, id: 99999}.to raise_error(ActiveRecord::RecordNotFound)
      end 
      it 'does not delete listing as doesnt belong to branch owned by agent / user' do
        # create user       
        user = create(:user)
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create age
        age = create(:age)
        # create availability
        availability = create(:availability)
        # create style
        style = create(:style)
        # create type
        type = create(:type)
        # create department
        department = create(:department, id: 2, value: 'Lettings')
        # create frequency
        frequency = create(:frequency)
        # create listing
        listing = create(
          :letting_listing, 
          branch_id: branch[:id],
          age_id: age[:id], 
          availability_id: availability[:id],
          style_id: style[:id],
          type_id: type[:id],
          department_id: department[:id],
          frequency_id: frequency[:id]
        )
        # Sign in as a different user
        sign_in create(:user)    
        # Expect pundit error as lisitng doesnt belong to user    
        expect{delete :destroy, id: listing}.to raise_error(Pundit::NotAuthorizedError)
      end       
    end   
  end  
end