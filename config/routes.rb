Rails.application.routes.draw do
  #scope :foreman_custom_tab, :path => '/custom_tab' do
    constraints(:id => /[^\/]+/) do
      resources :hosts do
        member do
          get 'custom_tab'
        end
      end
    end
  #end
end
