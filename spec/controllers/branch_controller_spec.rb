require 'rails_helper'

describe Admin::BranchesController do
  describe 'GET #index' do
    context 'when authenticated as user' do    
      it 'renders the :index template' do
        # Sign in to site as user        
        sign_in create(:user)
        # Get index action on controller
        get :index
        # expect response to render index view
        expect(response).to render_template :index
      end
      it 'populates an array of branches' do
        # Create user
        user = create(:user)
        # Sign in to site as user                
        sign_in user
        # Create agent for user
        agent = create(:agent, user: user)
        # Create couple of branches for agent
        branches = [create(:branch, agent: agent), create(:branch, agent: agent)]
        # Get index action on controller
        get :index
        # expect assignment of branches to match array of branches created
        expect(assigns(:branches)).to match_array(branches)    
      end 
    end     
  end

  describe 'GET #json' do
    it 'returns 2 agents via json' do
      # Create the user
      user = create(:user)
      # Sign in the user
      sign_in user
      # Create the agent
      agent = create(:agent, user: user)
      # Create couple of branches for agent
      create(:branch, agent: agent)
      create(:branch, agent: agent)
      # Get the branches for the agent
      get :json, {id: agent[:id]}
      # Expect the number of branches to equal 2
      expect(JSON.parse(response.body).length).to eq 2
    end
    it 'returns 0 branches when request for agent not belonging to logged in user' do
      # Create the users
      user1 = create(:user, email: 'test1@example.com')
      user2 = create(:user, email: 'test2@example.com')
      # Create the agents
      agent1 = create(:agent, user: user1)
      agent2 = create(:agent, user: user2)
      # Create couple of branches for agent2
      create(:branch, agent: agent2)
      create(:branch, agent: agent2)
      # Sign in the user as user1
      sign_in user1
      # Try to get the branches for the agent
      get :json, {id: agent2[:id]}
      # Expect the number of branches to be zero as you've requested
      # branches that don't belong to the user
      expect(JSON.parse(response.body).length).to eq 0
    end
    it 'returns only branches belonging to agent' do
      # Create the user
      user = create(:user)
      # Create the agents
      agent1 = create(:agent, user: user)
      agent2 = create(:agent, user: user)
      # Create couple of branches for agent1
      create(:branch, agent: agent1)
      create(:branch, agent: agent1)
      # Create a branch for agent2
      create(:branch, agent: agent2)
      # Sign in the user
      sign_in user
      # Try to get the branches for agent 1
      get :json, {id: agent1[:id]}
      # Expect the number of branches to be the 2 that belong to agent 1 
      expect(JSON.parse(response.body).length).to eq 2
    end
  end

  describe 'GET #new' do
    context 'when authenticated as user' do        
      it 'renders the :new template' do
        # sign in user
        sign_in create(:user)
        # get new action on controller
        get :new      
        # expect response to render new template
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #create' do
    context 'when authenticated as user' do                
      it 'creates a new branch' do
        # create user
        user = create(:user)
        # sign in user        
        sign_in user
        # create agent for user
        agent = create(:agent, user: user) 
        # attempt to create branch
        post :create, branch: attributes_for(:branch, agent_id: agent[:id])
        # expect response to redirect to admin_branches_path
        expect(response).to redirect_to admin_branches_path
        # expect flash that branch was created
        expect(flash[:notice]).to eq "Branch successfully created"
      end
      it 'fails to create a new branch as name is nil' do
        # create user
        user = create(:user)
        # sign in user        
        sign_in user
        # create agent for user
        agent = create(:agent, user: user) 
        # attempt to create branch
        post :create, branch: attributes_for(:branch, agent_id: agent[:id], name: nil)
        # Expect render of new template
        expect(response).to render_template :new
        # Expect flash message to say unable to create availability
        expect(flash[:alert]).to eq "Unable to create branch"
      end
    end
  end 

  describe 'GET #edit' do
    context 'when authenticated as admin' do                        
      it 'renders the :edit template' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent for user
        agent = create(:agent, user: user)
        # create branch for agent
        branch = create(:branch, agent: agent)
        # call edit acton on controller
        get :edit, id: branch
        # expect to render template
        expect(response).to render_template :edit      
      end   
      it 'fails to renders the :edit template, not found' do
        # login as user
        sign_in create(:user)
        # fail as branch doesnt exist
        expect{get :edit, id: 999999}.to raise_error(ActiveRecord::RecordNotFound)
      end    
    end 
  end

  describe 'PATCH #update' do
    context 'when authenticated as user' do                            
      it 'updates an branch' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)  
        # call update action on controller
        patch :update, id: branch, branch: attributes_for(:branch, name:'test2')
        # expect redirect to admin_branches_path
        expect(response).to redirect_to admin_branches_path  
        # expect flash notice to be successful
        expect(flash[:notice]).to eq "Branch successfully updated"      
      end
      it 'fails to update a branch as name nil' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch
        branch = create(:branch, agent: agent)  
        # call update action on controller
        patch :update, id: branch, branch: attributes_for(:branch, name: nil)
        # Expect response to render the edit template
        expect(response).to render_template :edit  
        # expect flash notice to be successful
        expect(flash[:alert]).to eq "Unable to update branch"  
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as user' do                            
      it 'deletes a branch' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # create branch for agent
        branch = create(:branch, agent: agent)      
        # expect number of branches to decrease as deleted
        expect{delete :destroy, id: branch}.to change(Branch, :count).by(-1)
      end
      it 'does not delete a branch, not found' do
        # Sign in as user
        sign_in create(:user)
        # Try to delete a non-existing branch and expect active record error
        expect{delete :destroy, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
      end        
    end
  end

end
