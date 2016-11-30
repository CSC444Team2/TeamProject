Rails.application.routes.draw do
  get 'home/index'

 	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	root 'home#index'

	get 'signup' => 'users#new'
	get 'login' => 'sessions#new', as: :login
	post 'login' => 'sessions#create'
	delete 'logout' => 'sessions#destroy'

  # PayPal payment processing
	post '/hook' => 'tournaments#hook'

	resources :tournaments do 
	  member do
	  	get :players, :organizers, :sponsors
	  	post :member_out_of_group, :add_member, :create_group, :delete_group
	  end
	end

	resources :users do
		member do
			get :played_events, :organized_events, :sponsored_events
		end
	end
	
	resources :golf_courses
	resources :join, only: [:create, :destroy]
	resources :requests, only: [:new, :create, :destroy]
	resources :password_resets
end
