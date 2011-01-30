class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_nda
    if !current_user.nda_signed
      return redirect_to :controller => "nda", :action => "index"
    end
  end

  def require_admin
    if !current_user || !current_user.admin
      flash[:alert] = "You must be loggedin as an admin to access this feature"
      return redirect_to(root_path)
    end
  end

  def add_params params_to_add
    new_p = params.dup
    new_p.delete(:page)
    new_p.delete(:auth)
    new_p.delete(:action)
    new_p.delete(:controller)
    new_p.merge! params_to_add
    new_p.to_hash
  end
end

