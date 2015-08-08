Rails.application.routes.draw do
	
	# SEO
  get "sitemap.xml" => "sitemap#index", :defaults => { format: 'xml' }
  get "sitemap.atom" => "sitemap#naver_seo", :defaults => { format: 'atom' }, as: :naver_seo_atom

	root "home#brandpage"

	get "about"		=> "home#about"
	get "manual"	=> "home#manual"
	get "qna"			=> "notices#index"
	get "search"	=> "home#search"
	get "home/update_subcategories"		# cascading select box 
	get "home/addrcomplete"						# autocomplete for address text_field

	resources :notices, 			 except: [:index, :show]
	resources :questions, 		 except: [:new]
	resources :rest_registers, except: [:edit, :update]

	# User & Admin with devise gem.
  devise_for :users, controllers: {
		passwords: "users/passwords",
		registrations: "users/registrations",
		sessions: "users/sessions"
		# confirmations: "users/confirmations",
		# unlocks: "users/unlocks",
		# omniauth_callbacks: "users/omniauth_callbacks"
	}
	get "users/profiles/:username" => "users/profiles#edit", as: :user_profile

	# Restaurant and nested controllers
	resources :restaurants, shallow: true do 
		resources :rest_infos,	 except: [:index, :show]
		resources :rest_errs, 	 except: [:index, :new]
		resources :menu_titles,  except: [:index, :show, :new]
		resources :menus, 		 	 except: [:index]
		resources :comments, 		 except: [:index, :add_menu, :update_menu]
		resources	:mymaps, 			 only: 	 [:new, :create]
	end

	# Index pages which is not bounded with :restaurants
	resources :franchises
	get 'rest_errs' 	=> 'rest_errs#index', 	as: :rest_errs
	get 'menu_titles' => 'menu_titles#index', as: :menu_titles
	get 'menus'				=> 'menus#index', 			as: :menus
	get 'comments' 		=> 'comments#index', 		as: :comments

	# Parsing foursquare images by Ajax loading.
	get 'foursquares/parse' => 'foursquares#parse'

	# Polymorphic picture controller
	resources :pictures

	# Address and related resources
	resources :addresses, shallow: true do
		resources :addr_conversions, except: [:index, :show]
	end

	# Index page which is not bounded with :addresses
	get 'addr_conversions' => 'addr_conversions#index', as: :addr_conversions

	resources :addr_rules, except: [:edit, :update]

	resources :slangs
	get "home/slang"

	# User specific routes
	# 'resources :users' needs just for nesting.
	resources :users, shallow: true do 
		resource :mymap_snapshot
	end

	# MyMap :new, :create depends on restaurants.
	resources :mymaps, except: [:index, :new, :create]

	get '/users/:username/MyMap' => 'mymaps#index', as: :mymap_index
	# Case insensitive redirection to users' MyMap page
	get '/users/:username/myMap' => redirect('users/%{username}/MyMap')
	get '/users/:username/Mymap' => redirect('users/%{username}/MyMap')
	get '/users/:username/mymap' => redirect('users/%{username}/MyMap')

	get '/users/:username/MyMap_list' => 'mymaps#list'
	# Redirection to MyMap_list
	get '/users/:username/mymap_list' => redirect('users/%{username}/MyMap_list')
	get '/users/:username/Mymap_list' => redirect('users/%{username}/MyMap_list')
	get '/users/:username/mymap_list' => redirect('users/%{username}/MyMap_list')

	scope module: 'admin' do
		resources :monitors
	end

	get "no_admin" => "admin/monitors#no_admin", as: :no_admin


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
