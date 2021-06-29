Rails.application.routes.draw do
  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #

  post '/upload/participants', to: 'welcome#participants'

  mount UPPY_S3_MULTIPART_APP => "/s3/multipart"
end
