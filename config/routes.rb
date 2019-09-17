Rails.application.routes.draw do

  api_version(:module => "V1", :path => {:value => "v1"}) do

    get '/auxiliary_records/delete', to: 'auxiliary_records#delete'
    resources :documents
    resources :workflows
    resources :auxiliary_tables
    resources :auxiliary_records


  end
end
