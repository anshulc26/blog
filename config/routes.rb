Blog::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  
  get '/admin', to: 'admin/dashboard#index'
  get '/admin/sign_in', to: 'admin#sign_in'
  namespace :admin do
    resources :dashboard, only: [:index] do
      collection do
        post :blog_allowed_to_show
        post :user_allowed_to_post
        post :user_allowed_to_comment
      end
    end
    resources :roles do
      member do
        get :destroy_show
      end
    end
    resources :blog_tags do
      member do
        get :destroy_show
      end
    end
  end
  get 'admin/blog_posts', to: 'admin/dashboard#blog_posts'
  get 'admin/users', to: 'admin/dashboard#users'
  get 'admin/add_role/:user_id', to: 'admin/dashboard#add_role', as: "add_role"
  post 'admin/add_roles_to_user/:user_id', to: 'admin/dashboard#add_roles_to_user', as: "add_roles_to_user"

  devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations', sessions: 'users/sessions', passwords: 'users/passwords'}, path: '', path_names: { sign_in: 'sign_in', sign_out: 'sign_out', sign_up: 'sign_up' }

  resources :contact, :only => [:index, :create]
  resources :blog_posts
  resources :error, :only => [:index]

  get '/:username/profile', to: 'profiles#index', as: 'profile', constraints: { username: /[\w+\.]+/ }
  get '/:username/edit_profile', to: 'profiles#edit_profile', as: 'edit_profile', constraints: { username: /[\w+\.]+/ }
  
  get "/about_us" => "global#about_us", as: "about_us"
  get "/team" => "global#team", as: "team"

  match '/users/:id/finish_signup' => 'global#finish_signup', via: [:get, :patch], as: :finish_signup
  
  get '*path' => redirect('/error')
  
  root 'home#index'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
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
