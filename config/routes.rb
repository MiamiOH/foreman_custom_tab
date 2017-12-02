Rails.application.routes.draw do
  constraints(:id => /[^\/]+/) do
    resources :hosts do
      member do
        get 'custom_tab'
      end
    end
  end
end
