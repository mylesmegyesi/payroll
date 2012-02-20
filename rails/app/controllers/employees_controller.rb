require 'payroll_core/employee/add_employee'

class EmployeesController < ApplicationController
  respond_to :json

  def create
    employee = params[:employee] || {}
    add_employee = Employee::AddEmployee.new(TRANSACTION_FACTORY)
    begin
      employee = add_employee.execute(employee)
    rescue ValidationError => e
      employee[:errors] = e.errors
    end
    render :json => employee.to_hash.to_json
  end

end
