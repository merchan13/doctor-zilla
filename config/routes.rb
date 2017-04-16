Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    authenticated do
      root to: 'pages#index'
    end
    unauthenticated do
      root to: 'devise/sessions#new'
    end
  end

  get '/:page/home', to: 'pages#home', as: 'option'

  resources :medical_records,   except: :destroy
  resources :occupations,       except: [:destroy, :edit, :update]
  resources :insurances,        except: [:destroy, :edit, :update]
  resources :consultations,     except: :destroy
  resources :reasons,           except: [:destroy, :edit, :update]
  resources :affections,        except: :destroy
  resources :backgrounds,       except: :destroy
  resources :basic_exams,       except: :destroy
  resources :physical_exams,    except: :destroy
  resources :evolutions,        except: :destroy
  resources :notes,             except: :destroy
  resources :diagnostics,       except: [:destroy, :edit, :update]

  get 'search', to: 'pages#search'
  get 'search_records', to: 'medical_records#search'

end
