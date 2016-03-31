require 'rails_helper'

describe Admin::AgentsController do
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
      it 'populates an array of agents' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create array of agents for user
        agents = [create(:agent, user: user), create(:agent, user: user)]
        # get index action
        get :index
        # expect agents variable to contain agents
        expect(assigns(:agents)).to match_array(agents)    
      end    
    end  
  end

  describe 'GET #json' do
    it 'returns 2 agents via json' do
      # Create the user
      user = create(:user)
      # Login the user
      sign_in user
      # Create couple of agents for user
      create(:agent, user: user)
      create(:agent, user: user)
      # Get via JSON
      get :json
      # Check that the number of agents returned is 2
      expect(JSON.parse(response.body).length).to eq 2
    end
    it 'only returns agents belonging to logged in user' do
      # create user1
      user1 = create(:user, email:'test1@example.com')
      # create user2
      user2 = create(:user, email:'test2@example.com')
      # create 2 agents for user 1
      agents_user1 = [create(:agent, user: user1), create(:agent, user: user1)]
      # create agent for user2
      agents_user2 = [create(:agent, user: user2)]
      # sign in user1
      sign_in user1
      # get json action
      get :json
      # expect json representing agents belonginging to logged in user (1)
      expect(JSON.parse(response.body).length).to eq 2
    end
    it 'has id key with value of 1 in returned json' do
      # create user
      user = create(:user)
      # sign in user
      sign_in user
      # create agent
      agent = create(:agent, id: 1, user: user)
      # get json action
      get :json
      # expect returned json to have key id with value 1
      expect(JSON.parse(response.body)[0]).to include('id' => 1)
    end
    it 'has name key with value of test in returned json' do
      # create user      
      user = create(:user)
      # sign in user            
      sign_in user
      # create agent
      agent = create(:agent, name: 'test', user: user)
      # get json action
      get :json
      # expect json array to include name key with value test
      expect(JSON.parse(response.body)[0]).to include('name' => 'test')
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
      it 'creates a new agent' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        post :create, agent: attributes_for(:agent, user: user)
        # expect response to redirect to admin_agents_path
        expect(response).to redirect_to admin_agents_path
        # expect flash notice to say agent created
        expect(flash[:notice]).to eq "Agent successfully created"
      end
      it 'fails to create new agent as name is nil' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        post :create, agent: attributes_for(:agent, user: user, name: nil)
        # Expect render of new template
        expect(response).to render_template :new
        # Expect flash message to say unable to create agent
        expect(flash[:alert]).to eq "Unable to create agent"
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
        # get agent action
        get :edit, id: agent
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
      it 'updates an agent' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # update the agent
        patch :update, id: agent, agent: attributes_for(:agent, name:'test2')    
        # expect response to redirect to admin_agents_path
        expect(response).to redirect_to admin_agents_path 
        # expect flash message respons 
        expect(flash[:notice]).to eq "Agent successfully updated"      
      end
      it 'fails to update an agent' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent
        agent = create(:agent, user: user)
        # update the agent
        patch :update, id: agent, agent: attributes_for(:agent, name: nil)    
        # Expect response to render the edit template
        expect(response).to render_template :edit
        # Expect flash message to say unable to create agent
        expect(flash[:alert]).to eq "Unable to update agent"   
      end

    end
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as user' do                        
      it 'deletes an agent' do
        # create user
        user = create(:user)
        # sign in user
        sign_in user
        # create agent for user
        agent = create(:agent, user: user)
        # delete agent
        expect{delete :destroy, id: agent}.to change(Agent, :count).by(-1)
      end
      it 'does not delete an agent, not found' do
        # Sign in as user
        sign_in create(:user)
        # Try to delete a non-existing agent and expect active record error
        expect{delete :destroy, id: 99999}.to raise_error(ActiveRecord::RecordNotFound)
      end         
    end
  end

end
