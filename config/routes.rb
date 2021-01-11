Rails.application.routes.draw do
  constraints(:id => %r{[^/]+}) do
    resources :hosts do
      member do
        get 'custom_tab'
      end
    end
  end
end
