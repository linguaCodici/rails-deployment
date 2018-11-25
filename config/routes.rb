Rails.application.routes.draw do
  root "ui#index"

  scope :api, defaults: {format: :json} do
    # Ex:- scope :active, -> {where(:active => true)}
    resources :foos, except: [:new, :edit]
    resources :bars, except: [:new, :edit]
  end

  get 'ui' => 'ui#index'
  get 'ui#' => 'ui#index'
end
