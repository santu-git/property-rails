require 'rails_helper'

describe Admin::DepartmentsController do
  describe 'GET #index' do
    context 'when authenticated as admin' do
      it 'renders the :index template' do
        sign_in create(:admin)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of departments' do
        sign_in create(:admin)
        departments = [create(:department, value:'test1'), create(:department, value:'test2')]
        get :index
        expect(assigns(:departments)).to match_array(departments)    
      end
    end
    context 'when authenticated as user' do
      it 'renders the :index template' do
        sign_in create(:user)
        get :index
        expect(response).to render_template :index
      end
      it 'populates an array of departments' do
        sign_in create(:admin)
        departments = [create(:department, value:'test1'), create(:department, value:'test2')]
        get :index
        expect(assigns(:departments)).to match_array(departments)    
      end      
    end
  end

  describe 'GET #new' do
    context 'when authenticated as admin' do    
      it 'renders the :new template' do
        sign_in create(:admin)
        get :new
        expect(response).to render_template :new
      end
    end
    context 'when authenticated as user' do
      it 'renders the :new template' do
        sign_in create(:user)
        expect{get :new}.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end

  describe 'POST #create' do
    it 'creates a new department' do
      sign_in create(:admin)
      post :create, department: attributes_for(:department)
      expect(response).to redirect_to admin_departments_path
      expect(flash[:notice]).to eq "Department successfully created"
    end
  end 

  describe 'GET #edit' do
    it 'renders the :edit template' do
      sign_in create(:admin)
      department = create(:department)
      get :edit, id: department[:id]
      expect(response).to render_template :edit      
    end   
    it 'fails to renders the :edit template, not found' do
      sign_in create(:admin)
      expect{get :edit, id: 9999}.to raise_error(ActiveRecord::RecordNotFound)
    end     
  end

  describe 'PATCH #update' do
    it 'updates a department' do
      sign_in create(:admin)
      department = create(:department)
      patch :update, id: department, department: attributes_for(:department, value:'test2')    
      expect(response).to redirect_to admin_departments_path  
      expect(flash[:notice]).to eq "Department successfully updated"      
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a department' do
      sign_in create(:admin)
      department = create(:department)
      expect{delete :destroy, id: department}.to change(Department, :count).by(-1)
    end
  end

end
