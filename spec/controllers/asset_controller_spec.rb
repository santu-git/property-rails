require 'rails_helper'

describe Admin::AssetsController do
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
      it 'populates an array of assets' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create department
        department = create(:department, id: 2)
        # create media_type
        media_type = create(:media_type, value:'image')        
        # create array of assets for user
        assets = [
          create(:jpg_asset, listing: create(:letting_listing, branch: branch, department: department), media_type: media_type), 
          create(:jpg_asset, listing: create(:letting_listing, branch: branch, department: department), media_type: media_type)
        ]
        # get index action
        get :index
        # expect assets variable to contain assets
        expect(assigns(:assets)).to match_array(assets)    
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
      it 'creates a new asset' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create department
        department = create(:department, id: 2)
        # create media_type
        media_type = create(:media_type, value:'image') 
        # create listing
        listing = create(:letting_listing, branch: branch, department: department)       
        # create asset
        post :create, asset: attributes_for(:jpg_asset, listing_id: listing[:id], media_type_id: media_type[:id])
        # expect response to redirect to admin_assets_path
        expect(response).to redirect_to admin_assets_path
        # expect flash notice to say asset created
        expect(flash[:notice]).to eq "Asset successfully created"
      end
      it 'fails to create new asset as status is nil' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create department
        department = create(:department, id: 2)
        # create media_type
        media_type = create(:media_type, value:'image') 
        # create listing
        listing = create(:letting_listing, branch: branch, department: department)               
        # create asset
        post :create, asset: attributes_for(:jpg_asset, listing_id: listing[:id], media_type_id: media_type[:id], status: nil)
        # Expect render of new template
        expect(response).to render_template :new
        # Expect flash message to say unable to create asset
        expect(flash[:alert]).to eq "Unable to create asset"
      end
    end
  end 

  describe 'GET #edit' do
    context 'when authenticated as user' do                
      it 'renders the :edit template' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create department
        department = create(:department, id: 2)
        # create media_type
        media_type = create(:media_type, value:'image') 
        # create listing
        listing = create(:letting_listing, branch: branch, department: department)                       
        # create asset
        asset = create(:jpg_asset, listing: create(:letting_listing, branch: branch, department: department), media_type: media_type)
        # get asset action
        get :edit, id: asset
        # expect response to render template
        expect(response).to render_template :edit      
      end   
      it 'fails to renders the :edit template, not found' do
        # sign in user
        sign_in create(:user)
        # expect a record not found erroe
        expect{get :edit, id: 99999}.to raise_error(ActiveRecord::RecordNotFound)
      end  
    end   
  end

  describe 'PATCH #update' do
    context 'when authenticated as user' do                    
      it 'updates an asset' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create department
        department = create(:department, id: 2)
        # create media_type
        media_type = create(:media_type, value:'image') 
        # create listing
        listing = create(:letting_listing, branch: branch, department: department)                       
        # create asset
        asset = create(:jpg_asset, listing: create(:letting_listing, branch: branch, department: department), media_type: media_type, status: 0)
        # update the asset
        patch :update, id: asset, asset: attributes_for(:jpg_asset, listing: create(:letting_listing, branch: branch, department: department), media_type: media_type, status: 1)    
        # expect response to redirect to admin_assets_path
        expect(response).to redirect_to admin_assets_path 
        # expect flash message respons 
        expect(flash[:notice]).to eq "Asset successfully updated"      
      end
      it 'fails to update an asset' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create department
        department = create(:department, id: 2)
        # create media_type
        media_type = create(:media_type, value:'image') 
        # create listing
        listing = create(:letting_listing, branch: branch, department: department)                       
        # create asset
        asset = create(:jpg_asset, listing: create(:letting_listing, branch: branch, department: department), media_type: media_type, status: 1)
        # update the asset
        patch :update, id: asset, asset: attributes_for(:jpg_asset, listing: create(:letting_listing, branch: branch, department: department), media_type: media_type, status: nil)    
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash message to say unable to create asset
        expect(flash[:alert]).to eq "Unable to update asset"   
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as user' do                        
      it 'deletes an asset' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)
        # create department
        department = create(:department, id: 2)
        # create media_type
        media_type = create(:media_type, value:'image') 
        # create listing
        listing = create(:letting_listing, branch: branch, department: department)                       
        # create asset
        asset = create(:jpg_asset, listing: create(:letting_listing, branch: branch, department: department), media_type: media_type, status: 1)
        # delete asset
        expect{delete :destroy, id: asset}.to change(Asset, :count).by(-1)
      end
      it 'does not delete an asset, not found' do
        # Sign in as user
        sign_in create(:user)
        # Try to delete a non-existing asset and expect active record error
        expect{delete :destroy, id: 99999}.to raise_error(ActiveRecord::RecordNotFound)
      end         
    end
  end
end
