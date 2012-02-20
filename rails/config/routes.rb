Payroll::Application.routes.draw do

  resources :employees, :only => [:create]

end
