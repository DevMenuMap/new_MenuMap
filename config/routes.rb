Rails.application.routes.draw do

	# SEO
  get "sitemap.xml"  => "sitemap#index",  	 defaults: { format: 'xml' }
  get "sitemap.atom" => "sitemap#naver_seo", defaults: { format: 'atom' }, as: :naver_seo_atom

	root "home#brandpage"

	get "about"		=> "home#about"
	get "manual"	=> "home#manual"
	get "qna"			=> "notices#index"
	get "search"	=> "home#search"
	get "home/update_subcategories"		# cascading select box 
	get "home/addrcomplete"						# autocomplete for address text_field
	get "home/info_window"						# infoWindow over map.

	resources :notices, 			 except: [:index, :show]
	resources :questions, 		 except: [:show, :edit, :update]
	resources :rest_registers, except: [:edit, :update]

	# User & Admin with devise gem.
  devise_for :users, controllers: {
		passwords: "users/passwords",
		registrations: "users/registrations",
		sessions: "users/sessions",
		confirmations: "users/confirmations",
		# unlocks: "users/unlocks",
		omniauth_callbacks: "users/omniauth_callbacks"
	}
	get "users/profiles/:username" => "users/profiles#edit", as: :user_profile

	# Restaurant and nested controllers.
	resources :restaurants, shallow: true do 
		resources :rest_infos,	 except: [:index, :show]
		resources :rest_errs, 	 except: [:index, :show, :edit]

		resources :menu_titles,  except: [:index, :show, :new]
		resources :menus, 		 	 except: [:index] do
			# Cancel the menu editing operation.
			get 'cancel', on: :member

			# Ajax call to get comments of menu.
			resources :menu_comments, only: [:index] do
				get 'more', on: :collection
			end
		end

		resources :comments, 		 except: [:index, :show, :new] do
			# Show more comments in restaurants#show.
			get 'more', on: :collection
			# Show edit or delete link modal.
			get 'modal', on: :member
			# Cancel comments#edit.
			get 'cancel', on: :member
		end

		resources	:mymaps, 			 only: 	 [:new, :create]

		# Menu tagging autocomplete list.
		get 'menu_complete', on: :member
	end

	# Index pages which is not bounded with :restaurants
	resources :franchises
	resources :rest_errs, only: [:index]
	get 'menu_titles' => 'menu_titles#index', as: :menu_titles
	get 'menus'				=> 'menus#index', 			as: :menus
	resources :comments, only: [:index]

	# Parsing foursquare images by Ajax loading.
	get 'foursquares/parse' => 'foursquares#parse'

	# Parsing blog results.
	get 'blogs/blog_ajax'

	# Share restaurant on SNS.
	get 'socials/share_rest/:restaurant_id' => 'socials#share_rest', as: :share_rest

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
	get "home/validate_slangs"

	# User specific routes
	resources :users, shallow: true do 
		resource :mymap_snapshot, only: [:show, :create]
	end

	# MyMap :new, :create depends on restaurants.
	resources :mymaps, except: [:index, :new, :create]

	get '/users/:username/MyMap' => 'mymaps#index', as: :mymap_index
	# Case insensitive redirection to users' MyMap page
	get '/users/:username/:mymap' => redirect('/users/%{username}/MyMap'), 
																	 constraints: { mymap: /mymap/i }

	scope module: 'admin' do
		resources :monitors, only: [:index]
	end
end
