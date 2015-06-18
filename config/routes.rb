Rails.application.routes.draw do
	
	root "home#brandpage"

	get "about"		=> "home#about"
	get "manual"	=> "home#manual"
	get "qna"			=> "notices#index"

	get "search"	=> "home#search"
	# cascading select box
	get "home/update_subcategories"
	# autocomplete for address text_field
	get "home/addrcomplete"

	resources :notices, 			 except: [:index, :show]
	resources :questions, 		 except: [:new]
	resources :rest_registers, except: [:edit, :update]

	# User & Admin with devise gem.
  devise_for :users, controllers: {
		# confirmations: "users/confirmations",
		passwords: "users/passwords",
		registrations: "users/registrations",
		sessions: "users/sessions",
		# unlocks: "users/unlocks",
		# omniauth_callbacks: "users/omniauth_callbacks"
	}

	# Restaurant and related controllers
	resources :restaurants, shallow: true do 
		resources :rest_infos,	 except: [:index]
		resources :rest_errs, 	 except: [:index, :new]
	end

	# rest_errs#index without assciations to restaurants
	get "rest_errs" => "rest_errs#index", as: "rest_errs"

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
