factory :os do
  name 'CentOS'
  major '7'
  type 'Redhat'
end

factory :host do
  name 'foreman_custom_tab'
  mac '00:00:00:00:00:00'
  certname 'foreman_custom_tab'
  ip '127.0.0.1'
  certname 'host.test.com'
  arch FactoryBot.create(:architecture)
  operatingsystem os
end
