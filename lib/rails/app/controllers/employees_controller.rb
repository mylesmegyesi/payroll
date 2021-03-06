require 'core/employee/interactor/create'
require 'core/employee/interactor/delete_by_id'

class EmployeesController < ApplicationController
  respond_to :json

  def create
    employee = params[:employee] || {}
    create_employee = Core::Employee::Interactor::Create.new(TRANSACTION_FACTORY)
    begin
      employee = create_employee.execute(employee)
    rescue Core::Error::ValidationError => e
      employee[:errors] = e.errors
    end
    render :json => employee.to_hash.to_json
  end

  def destroy
    id = params[:id].to_i
    delete_employee = Core::Employee::Interactor::DeleteByID.new(TRANSACTION_FACTORY)
    begin
      delete_employee.execute(id)
      render :json => {:success => true}
    rescue Core::Error::RecordNotFound
      render :json => {:success => false, :message => 'record not found'} 
    end
  end

end
