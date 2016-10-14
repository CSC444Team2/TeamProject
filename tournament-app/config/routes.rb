Rails.application.routes.draw do
  get 'home/index'

 	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	root 'home#index'
	#!!!! Do NOT use "form_for :blah", use "form_for(@blah)"!!!...
	#post 'tournaments/new' => 'tournaments#create'
	#post 'tournaments/:id/edit' => 'tournaments#create'
	#!!!!

	get 'signup' => 'users#new'
	get 'login' => 'sessions#new', as: :login
	post 'login' => 'sessions#create'
	delete 'logout' => 'sessions#destroy'

	resources :tournaments do 
	  resources :player_groups
	end

	resources :users
end
