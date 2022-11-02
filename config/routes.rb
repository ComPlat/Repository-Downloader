# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root "spa#index"
  mount API::Base => "/api"
  mount GrapeSwaggerRails::Engine => "/swagger"
end
