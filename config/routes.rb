Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "spa#index"
  mount API::Base => "/api"
  mount GrapeSwaggerRails::Engine => "/swagger"
end
