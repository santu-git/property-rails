require 'rails_helper'

describe Admin::AgentsController do
  describe 'GET #index' do
    it 'renders the :index template' do
      sign_in create(:user)
      get :index
      expect(response).to render_template :index
    end
    it 'populates an array of agents' do
      user = create(:user)
      sign_in user
      agents = [create(:agent, user: user), create(:agent, user: user)]
      get :index
      expect(assigns(:agents)).to match_array(agents)    
    end      
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      sign_in create(:user)
      get :new      
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it 'creates a new agent' do
      user = create(:user)
      sign_in user
      post :create, agent: attributes_for(:agent, user: user)
      expect(response).to redirect_to admin_agents_path
      expect(flash[:notice]).to eq "Agent successfully created"
    end
  end 

  describe 'GET #edit' do
    it 'renders the :edit template' do
      user = create(:user)
      sign_in user
      agent = create(:agent, user: user)
      get :edit, id: agent[:id]
      expect(response).to render_template :edit      
    end   
    it 'fails to renders the :edit template, not found' do
      sign_in create(:admin)
      expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
    end     
  end

  describe 'PATCH #update' do
    it 'updates an agent' do
      user = create(:user)
      sign_in user
      agent = create(:agent, user: user)
      patch :update, id: agent, agent: attributes_for(:agent, name:'test2')    
      expect(response).to redirect_to admin_agents_path  
      expect(flash[:notice]).to eq "Agent successfully updated"      
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes an agent' do
      user = create(:user)
      sign_in user
      agent = create(:agent, user: user)
      expect{delete :destroy, id: agent}.to change(Agent, :count).by(-1)
    end
  end

end
