class LoginsController < ApplicationController
  skip_before_action :require_user, only: [:new, :create]
    def new
      # This renders a login form (by default, it will look for a `new.html.erb` view)
    end
  
    def create
      student = Student.find_by(email: params[:logins][:email].downcase)
      if student && student.authenticate(params[:logins][:password])
        session[:student_id] = student.id
        flash[:notice] = "You have successfully logged in"
        redirect_to student
      else
        flash.now[:notice] = "something was wrong with your login information"
        render 'new'
      end
    end
  
    def destroy
      session[:student_id] = nil
      flash[:notice]= "you have successfully logout"
      redirect_to root_path
    end
  end
  