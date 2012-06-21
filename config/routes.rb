Bc::Application.routes.draw do

#===============================================================================
#                                                                              #
#   If you change this file think about changing the sitemap.rb file as well   #
#                                                                              #
#===============================================================================
  post "voice"                        => 'voice#index'
  post "voice/hangup"                 => 'voice#hangup'
  post "voice/process_service_number" => 'voice#process_service_number'
  post "voice/confirm_service_number" => 'voice#confirm_service_number'
  post "voice/after_review"           => 'voice#after_review'
  post "voice/capture_recording"      => 'voice#capture_recording'

  post "voice/twilio"                        => 'voice#twilio_index'
  post "voice/twilio_hangup"                 => 'voice#twilio_hangup'
  post "voice/twilio_process_service_number" => 'voice#twilio_process_service_number'
  post "voice/twilio_confirm_service_number" => 'voice#twilio_confirm_service_number'
  post "voice/twilio_after_review"           => 'voice#twilio_after_review'
  post "voice/twilio_capture_recording"      => 'voice#twilio_capture_recording'
  post "voice/twilio_got_reviewer_type"      => 'voice#twilio_got_reviewer_type'
  post "voice/twilio_got_stars"              => 'voice#twilio_got_stars'
  post "voice/twilio_captured_name"          => 'voice#twilio_captured_name'

#  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :towns

  match 'services/my_services' => 'services#my_services', :as => :my_services

  resources :services do
    collection do
      get 'search'
    end
  end

  resources :ratings

  match 'services/:id/claim'          => 'services#claim',           :as => :claim
  match 'services/:id/sendcode'       => 'services#sendcode',        :as => :sendcode

  match 'permissions/enter_codes'     => 'permissions#enter_codes',  :as => :enter_codes
  match 'permissions/:id/enter_code'  => 'permissions#enter_code',   :as => :enter_code
  match 'permissions/:id/process_code'=> 'permissions#process_code', :as => :process_code

  match 'ratings/:service_id/prepare' => 'ratings#prepare',          :as => :rate_service
  match 'ratings/:id/preview'         => 'ratings#preview',          :as => :preview_rating
  match 'ratings/:id/publish'         => 'ratings#publish',          :as => :publish_rating
  match 'ratings/:id/abandon'         => 'ratings#abandon',          :as => :abandon_rating
  match 'ratings/:id/amend'           => 'ratings#amend',            :as => :amend_rating
  match 'ratings/:id/respond'         => 'ratings#respond',          :as => :rating_respond
  match 'ratings/store'               => 'ratings#store',            :as => :store_rating
  match 'ratings/modify'              => 'ratings#modify',           :as => :modify_rating
  match 'ratings/process_response'    => 'ratings#process_response', :as => :process_rating_response

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
  root :to => "services#home"

  devise_for :users
  match 'users/:id/dashboard' => 'users#dashboard', :as => :dashboard

  get "pages/contact", :as => 'contact'
  get "pages/newsession", :as => 'newsession'
  get "pages/help", :as => 'help'
  get "pages/about", :as => 'about'
  get "pages/textile", :as => 'textile'
  get "pages/terms", :as => 'terms'
  get "pages/privacy", :as => 'privacy'
  get "pages/cookie_policy", :as => 'cookie_policy'
  get 'pages/accept_cookies', :as => 'accept_cookies'
  get "pages/opensource", :as => 'opensource'
  get "pages/provider_guide", :as => 'provider_guide'

  resources :ownership_types

  resources :permissions

  resources :phone_types

  resources :rater_types

  resources :public_scores_statuses

  resources :public_scores

  resources :comments

  resources :internal_service_types

  resources :internal_sector_types

  resources :regulator_service_types

  resources :regulator_sector_types

  resources :internal_regulator_scores

  resources :regulator_scores

  resources :regulators

  resources :countries

  resources :phones

  resources :employments

  resources :ownerships

  resources :people

  resources :address_types

  resources :addresses

  resources :organisations

  match 'users' => 'users#index'
  match 'dashboard' => 'users#mydashboard'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
