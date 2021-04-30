class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :store_location
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    # Pundit
    before_action  :authenticate_user!
    include Pundit
  
    # Pundit: white-list approach.
    after_action :verify_authorized, except: :index, unless: :skip_pundit?
    after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  
    # Uncomment when you *really understand* Pundit!
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    def user_not_authorized
       flash[:alert] = "You are not authorized to perform this action."
       redirect_to(root_path)
    end
  
    private
  
    def skip_pundit?
      devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
    end
  
    # Redirect_to same location for Devise
    def store_location
      if(request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        request.path != "/users" &&
        !request.xhr? && !current_user) # don't store ajax calls
        session[:previous_url] = request.fullpath
      end
    end
  
    def after_sign_in_path_for(resource)
      previous_path = session[:previous_url]
      session[:previous_url] = nil
      previous_path || root_path
    end
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:nickname, :email, :password, :password_confirmation)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:avatar, :nickname, :email, :password, :password_confirmation, :current_password)}
    end  
end
