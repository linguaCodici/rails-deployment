Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do
  # Ex:- scope :active, -> {where(:active => true)}
    resources :foos, except: [:new, :edit]
  end
end
