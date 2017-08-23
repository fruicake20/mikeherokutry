class AccessController < ApplicationController
 

  layout :resolve_layout

  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]


  def index
      menu
      render('menu')
  end

  def menu

  end

  def login
     
  end

  def attempt_login
  	authorized_user = AdminUser.authenticate(params[:username], params[:password])
  	if authorized_user
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.first_name + " " + authorized_user.last_name
      session[:userpic] =  authorized_user.userpic.public_filename(:thumbnail)


  		flash[:notice] = "You are now logged in."
  		redirect_to(:action => 'menu')
  	else
  		flash[:notice] = "Invalid username/password combination."
  		redirect_to(:action => 'login')
  	end

  end

  def logout
      session[:user_id] = nil
      session[:username] = nil
        session[:userpic] =  nil
 	  	flash[:notice] = "You have been Logged out"
  		redirect_to(:action => 'login')
  end



   private   
      def resolve_layout
      


       case action_name
         when 'login'
             "login"
         else 
             "admin"
         end
      end

end
