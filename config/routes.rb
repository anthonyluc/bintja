Rails.application.routes.draw do
  # Redirection routes utilisateurs  
  devise_for :users, :controllers => { :registrations => :registrations, :passwords => :passwords }

end
