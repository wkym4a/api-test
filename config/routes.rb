Rails.application.routes.draw do
  apipie
  namespace 'api' do
    namespace 'v1' do
      resources :posts
      resources :tests
    end
  end
end
