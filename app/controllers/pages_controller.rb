class PagesController < ApplicationController

	layout :resolve_layout

	before_filter :confirm_logged_in
	before_filter :find_subject

	def index
		list
		render('list')
	end

	def list
		@subject_pages= Page.where(:subject_id => @subject.id)
		@pages = Page.sorted.where(:subject_id => @subject.id).paginate(page: params[:page], per_page: 2)
	end

	def show
		@page = Page.find(params[:id])
	end

	def new
		@page = Page.new(:subject_id => @subject.id)
		@page_count = @subject.pages.size + 1
		@subjects = Subject.order('position ASC')
	end

	def create
		
		new_position = params[:page].delete(:position)

		@page = Page.new(params[:page])

		if @page.save
			@page.move_to_position(new_position)
			flash[:notice]= "Page created"
			redirect_to(:action => 'list', :subject_id => @page.subject_id)
		else
			@page_count = @subject.pages.size + 1
			@subjects = Subject.order('position ASC')
			render('new')
		end
	end

	def edit
		@page = Page.find(params[:id])
		@page_count = @subject.pages.size
		@subjects = Subject.order('position ASC')
	end

	def update

		@page = Page.find(params[:id])

		new_position = params[:page].delete(:position)

		if @page.update_attributes(params[:page])
			@page.move_to_position(new_position)
			flash[:notice] = "Page Updated"
			redirect_to(:action => 'show', :id => @page.id, :subject_id => @page.subject_id)
		else
			@page_count= @subject.pages.size
			@subjects = Subject.order('position ASC')
			render('edit')
		end

	end

=begin
	def delete
		@page = Page.find(params[:id])
	end
=end

	def delete
		page = Page.find(params[:id])
		page.move_to_position(nil)
		page.destroy
		flash[:notice] = "Page destroyed"
		redirect_to(:action => 'list', :subject_id => @subject.id)

	end

	private

	def find_subject
		
		if params[:subject_id]
			@subject = Subject.find_by_id(params[:subject_id])
		end
	
	end


      def resolve_layout
       case action_name
         when 'show'
             "show"
         else 
             "admin"
         end
      end

end
