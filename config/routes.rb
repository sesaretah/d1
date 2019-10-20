Rails.application.routes.draw do

  api_version(:module => "V1", :path => {:value => "v1"}) do

    get '/auxiliary_records/delete', to: 'auxiliary_records#delete'
    get '/auxiliary_tables/multiple', to: 'auxiliary_tables#multiple'
    get '/workflow_tables/delete', to: 'workflow_tables#delete'

    resources :roles
    resources :documents
    resources :workflows
    resources :auxiliary_tables
    resources :auxiliary_records
    resources :workflow_tables
    get '/auxiliary_tables/records/:id', to: 'auxiliary_tables#records'

  end
end
