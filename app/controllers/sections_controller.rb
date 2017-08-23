class SectionsController < ApplicationController

	  layout :resolve_layout

	  before_filter :confirm_logged_in
	  before_filter :find_page
	  before_filter :find_subject

	  def index
	  	list
	  	render('list')
	  end

	  def list
	  	@page_sections =Section.where(:page_id => @page.id)
	  	@sections = Section.sorted.where(:page_id => @page.id).paginate(page: params[:page], per_page: 2)
	  end

	  def show
	  	@section = Section.find(params[:id])
	  end

	  def new
	  	@section = Section.new(:page_id => @page_id)
	  	@section_count = @page.sections.size + 1
	  	@pages = Page.order('position ASC')
	  end

	  def create

	  	new_position = params[:section].delete(:position)

	  	@section = Section.new(params[:section])

	  	if @section.save
	  		@section.move_to_position(new_position)
	  		flash[:notice] = "Section Created."
	  		redirect_to(:action => 'list', :page_id => @section.page_id)
	  	else
	  		@section_count= @page.sections.size + 1
	  		@pages = Page.order('position ASC')
	  		render('new')

	  	end

	  end

	  def edit
	  	@section = Section.find(params[:id])
	  	@section_count = @page.sections.size
	  	@pages = Page.order('position ASC')
	  end

	  def update
	  	@section = Section.find(params[:id])

	  	new_position = params[:section].delete(:position)

	  	if @section.update_attributes(params[:section])
	  		@section.move_to_position(new_position)
	  		flash[:notice] = "Section updated."
	  		redirect_to(:action => 'show', :id => @section.id, :page_id => @section.page_id)
	  	else
	  		@section_count = @page.sections.size
	  		@pages = Page.order('position ASC')
	  		render('edit')
	  	end

	  end

=begin	  def delete
	  	@section = Section.find(params[:id])
	  end
=end

	  def delete
	  	section = Section.find(params[:id])
		section.move_to_position(nil)
	  	section.destroy
	  	flash[:notice]="Section destroyed."
	  	redirect_to(:action => 'list', :page_id => @page.id)
	  end

	  private

	  def find_page
	  
	  	if params[:page_id]
	  		@page = Page.find_by_id(params[:page_id])
	  	end
	  
	  end

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
