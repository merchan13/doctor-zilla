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
  resources :budgets,           except: [:destroy, :edit, :update]
  resources :consultations,     except: :destroy
  resources :diagnostics,       except: [:destroy, :edit, :update]
  resources :equipments,        except: [:destroy, :edit, :update]
  resources :insurances,        except: [:destroy, :edit, :update]
  resources :medical_records,   except: :destroy
  resources :medicines,         except: [:destroy, :edit, :update]
  resources :occupations,       except: [:destroy, :edit, :update]
  resources :operative_notes,   except: [:edit, :update]
  resources :physical_exams,    except: :destroy
  resources :plans,             only:   :index
  resources :prescriptions,     except: [:destroy, :edit, :update]
  resources :procedures,        except: [:destroy, :edit, :update]
  resources :reports,           except: [:edit, :update]
  resources :reasons,           except: [:destroy, :edit, :update]

  post 'medical_records/:id/change_important_status', to: 'medical_records#important_status'

  get 'search',                 to: 'pages#search'
  get 'search_records',         to: 'medical_records#search'
  get 'search_plans',           to: 'plans#search'
  get 'select_data',            to: 'reports#select_data'
  get 'administration',         to: 'pages#administration'
  get 'activities',             to: 'activities#general'
  get 'custom_activities',      to: 'activities#custom'
  get 'reset_drzilla_password', to: 'pages#reset_drzilla_password'
  post 'send_new_password',     to: 'pages#send_drzilla_password'

  get 'reports/download/:id',         to: 'reports#download',         as: 'download_report',        format: 'docx'
  get 'prescriptions/download/:id',   to: 'prescriptions#download',   as: 'download_prescription',  format: 'docx'
  get 'operative_notes/download/:id', to: 'operative_notes#download', as: 'download_operative',     format: 'docx'
  get 'budgets/download/:id',         to: 'budgets#download',         as: 'download_budget',        format: 'docx'

end
