Rails.application.routes.draw do
  get 'home/index'

 	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	root 'home#index'
  	
	get 'signup' => 'users#new'
	get 'login' => 'sessions#new', as: :login
	post 'login' => 'sessions#create'
	delete 'logout' => 'sessions#destroy'

  # PayPal payment processing
	post '/hook_sponsor' => 'tournaments#hook_sponsor'
	post '/hook_play' => 'tournaments#hook_play'

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
	post '/operate_golf_course' => 'golf_courses#operate_course'
	post '/not_operate_golf_course' => 'golf_courses#stop_operate'

	resources :join, only: [:create, :destroy]
	resources :tickets
	resources :requests, only: [:new, :create, :destroy]
	resources :golf_requests, only: [:new, :create, :destroy]
	resources :password_resets

	get "/pages/:page" => "pages#show"	
	#NOTE: this should appear at VERY end for not found pages
	get '*unmatched_route', to: 'home#not_found'
end
