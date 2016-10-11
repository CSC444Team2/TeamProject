Rails.application.routes.draw do
 	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	root 'tournaments#index'
	#!!!! Do NOT use "form_for :blah", use "form_for(@blah)"!!!...
	#post 'tournaments/new' => 'tournaments#create'
	#post 'tournaments/:id/edit' => 'tournaments#create'
	#!!!!
	resources :tournaments do 
	  resources :player_groups
	end

	resources :users
end
