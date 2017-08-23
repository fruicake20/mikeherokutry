class SubjectsController < ApplicationController

	layout :resolve_layout

	before_filter :confirm_logged_in

	def index
		list
		render('list')
	end


	def list
		@subjects_all = Subject.all
		@subjects = Subject.order("subjects.position ASC").paginate(page: params[:page], per_page: 2)
	end

	def show
		@subject = Subject.find(params[:id])
	end

	def new
		@subject = Subject.new(:name => '')
		@subject_count = Subject.count + 1
	end

	def create
		new_position = params[:subject].delete(:position)


		@subject = Subject.new(params[:subject])
		if @subject.save
			@subject.move_to_position(new_position)
			redirect_to(:action => 'list')
			flash[:notice] = "Subject created."
		else
			@subject_count = Subject.count + 1
			render('new')
		end
	end

	def edit
		@subject = Subject.find(params[:id])
		@subject_count = Subject.count
	end

	def update
		@subject = Subject.find(params[:id])

		new_position = params[:subject].delete(:position)	

		if @subject.update_attributes(params[:subject]) 
			@subject.move_to_position(new_position)
			redirect_to(:action => 'show',:id => @subject.id)
			flash[:notice] = "Subject updated."
		else
			@subject_count = Subject.count
			render('edit')
		end
	end

=begin	def delete
		@subject = Subject.find(params[:id])
	end
=end

	def delete
		subject = Subject.find(params[:id])
		subject.move_to_position(nil)
		subject.destroy
		redirect_to(:action => 'list')
		flash[:notice] = "Subject destroyed."
	end


	 private   
      def resolve_layout
      


       case action_name
         when 'show'
             "show"
         else 
             "admin"
         end
      end

end
