class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_student

  def after_sign_in_path_for(resource)
    case resource
      when Teacher then dashboard_teachers_path
    end
  end

  def current_student
    return unless session[:student_id]
  	Student.find session[:student_id]

  rescue ActiveRecord::RecordNotFound
    session[:student_id] = nil
  end

  def authenticate_student!
    unless current_student
      flash[:notice] = 'You need to sign in'
      redirect_to students_dashboard_path
    end
  end
end
