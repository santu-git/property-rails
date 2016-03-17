require 'rails_helper'

describe Admin::BranchesController do
  describe 'GET #index' do
    it 'renders the :index template' do
      sign_in create(:user)
      get :index
      expect(response).to render_template :index
    end
    it 'populates an array of branches' do
      user = create(:user)
      sign_in user
      agent = create(:agent, user: user)
      branches = [create(:branch, agent: agent), create(:branch, agent: agent)]
      get :index
      expect(assigns(:branches)).to match_array(branches)    
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
    it 'creates a new branch' do
      user = create(:user)
      sign_in user
      agent = create(:agent, user: user) 
      post :create, branch: attributes_for(:branch, agent_id: agent[:id])
      expect(response).to redirect_to admin_branches_path
      expect(flash[:notice]).to eq "Branch successfully created"
    end
  end 

  describe 'GET #edit' do
    it 'renders the :edit template' do
      user = create(:user)
      sign_in user
      agent = create(:agent, user: user)
      branch = create(:branch, agent: agent)
      get :edit, id: branch[:id]
      expect(response).to render_template :edit      
    end   
    it 'fails to renders the :edit template, not found' do
      sign_in create(:admin)
      expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
    end     
  end

  describe 'PATCH #update' do
    it 'updates an branch' do
      user = create(:user)
      sign_in user
      agent = create(:agent, user: user)
      branch = create(:branch, agent: agent)  
      patch :update, id: branch, branch: attributes_for(:branch, name:'test2')
      expect(response).to redirect_to admin_branches_path  
      expect(flash[:notice]).to eq "Branch successfully updated"      
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a branch' do
      user = create(:user)
      sign_in user
      agent = create(:agent, user: user)
      branch = create(:branch, agent: agent)      
      expect{delete :destroy, id: branch}.to change(Branch, :count).by(-1)
    end
  end

end
