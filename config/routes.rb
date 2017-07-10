Rails.application.routes.draw do

  devise_for :users
  resources :users_admin, only: [:show, :new, :create], :controller => 'users'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  devise_scope :user do
    authenticated do
      root to: 'pages#index'
    end
    unauthenticated do
      root to: 'devise/sessions#new'
    end
  end

  get '/:page/home',      to: 'pages#home', as: 'option'

  resources :attachments,       except: [:edit, :update]
  resources :backgrounds,       except: :destroy
  resources :consultations,     except: :destroy
  resources :diagnostics,       except: [:destroy, :edit, :update]
  resources :insurances,        except: [:destroy, :edit, :update]
  resources :medical_records,   except: :destroy
  resources :medicines,         except: [:destroy, :edit, :update]
  resources :occupations,       except: [:destroy, :edit, :update]
  resources :operative_notes,   except: [:destroy, :edit, :update]
  resources :physical_exams,    except: :destroy
  resources :prescriptions,     except: [:destroy, :edit, :update]
  resources :procedures,        except: [:destroy, :edit, :update]
  resources :reports,            except: [:destroy, :edit, :update]
  resources :reasons,           except: [:destroy, :edit, :update]

  get 'search',           to: 'pages#search'
  get 'search_records',   to: 'medical_records#search'
  get 'search_plans',     to: 'plans#search'
  get 'select_data',      to: 'reports#select_data'
  get 'administration',   to: 'pages#administration'

end
