class AdminUsersController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in

  def index
      
  	list
  	render('list')

  end 

  def list

 	  @admin_users = AdminUser.all
    @user_pics = Userpic.where(["parent_id is null"])


  end

  def new

    @admin_user = AdminUser.new
    @userpic = Userpic.new
    
  end

  def create
  
  	@admin_user = AdminUser.new(params[:admin_user])
   
  	if @admin_user.save 

      @userpic = Userpic.new(params[:userpic])
      @userpic.admin_user_id = @admin_user.id

      if @userpic.save

      flash[:notice] = 'Admin User created.'

      UserEventMailer.created_user_mailer(@admin_user,request.remote_ip).deliver 

      redirect_to(:action => 'list')

      else

      render("new")

      end

  	else
  		render("new")
  	end

  end

  def edit

  	@admin_user = AdminUser.find(params[:id])
    @userpic = Userpic.find_by_admin_user_id(params[:id])

    render :layout => false

  end


  def update

  	@admin_user = AdminUser.find(params[:id])
    
    @userpic = Userpic.find_by_admin_user_id(params[:id])

    @userpic.update_attributes(params[:userpic])

    #@thepostcard = Thepostcard.find(params[:id])
    #@thepostcard.update_attributes(params[:thepostcard])


  	if @admin_user.update_attributes(params[:admin_user]) 
     
  		#flash[:notice]='Admin user updated.'
  		#redirect_to(:action => 'list')

  	else

  		#render('edit')

  	end

   # render :layout => false

  end


=begin  def delete
  	@admin_user = AdminUser.find(params[:id])
  end 
=end

  def delete
  	AdminUser.find(params[:id]).destroy
    Userpic.find_by_admin_user_id(params[:id]).destroy
  	flash[:notice] = "Admin user destroyed"
  	redirect_to(:action => 'list')
  end



    def datalist

    #  thename = params[:name].strip

      thename = params[:name]

      condition_params = ""

      if thename.present?

      condition_params = " (lower(concat(first_name,' ',last_name)) like '%#{thename.downcase}%')"

      end


      page = (params[:page]).to_i

      rp = (params[:rp]).to_i
      sortname = params[:sortname]
      sortorder = params[:sortorder]
      if (!sortname)
        sortname = "businesses.business_name"
      end
      if (!sortorder)
        sortorder = "asc"
      end
      if (!page)
        page = 1
      end
      if (!rp)
        rp = 15
      end
      start = ((page-1) * rp).to_i



     
    #   @businesses = Business.find(:all,
    #       #:joins => "LEFT JOIN premium_listings on (premium_listings.business_id=businesses.id and premium_listings.pl_status='active')",
    #       :order => sortname+' '+sortorder,
    #       #:group => "businesses.id,businesses.business_name,businesses.trade_name",
    #       :limit =>rp,
    #       :offset =>start,
    #       :select => "  businesses.id,businesses.business_name,businesses.trade_name,
    #       businesses.permalink,businesses.unit_no,
    #  businesses.building_name,businesses.street_no,
    #  businesses.street_name,businesses.village,businesses.barangay,
    #  (select display_name from locations where id=businesses.location_id) as location_name, businesses.zip_code",
    #       :conditions=>condition_params)
    # count = Business.count(:all,
    #     :conditions=>condition_params)



    #@admin_users = AdminUser.sorted
    @admin_users = AdminUser.find(:all,
          :conditions=>condition_params)


    count = AdminUser.count(:all,  
             :conditions=>condition_params)       
# <table class="table">
#     <thead>
#     <tr>
    
#       <th style="border-top-left-radius: 10px;">Picture</th>
#       <th>Username</th>
#       <th>Name</th>
#       <th>Email</th>
#       <th style="border-top-right-radius: 10px;width:150px;">Actions</th>
#      </tr>
#     </thead>
#     <tbody>
#        <% @admin_users.each do |admin_user| %>
#      <tr class="<%= cycle('odd', 'even')%>" >
#       <%# image_tag(thepostcard.public_filename(:thumbnail)) %>
#       <%# image_tag(admin_user.userpic.public_filename()) %>
#       <%# admin_user.userpic %>
#       <td style="text-align: center;"><%= image_tag(admin_user.userpic.public_filename(:thumbnail)) %></td>
#       <td><%= admin_user.username %></td>
#       <td><%= admin_user.name %></td>
#       <td><%= mail_to(admin_user.email) %></td>
#       <td style="width:120px;">
#       <%# link_to('Edit', {:action => 'edit', :id => admin_user.id}, :class => 'action edit') %>
#       <%# link_to('Delete', {:action => 'delete', :id => admin_user.id}, :class => 'action delete') %>

#     <%# link_to 'Delete', { action: 'delete' ,id: admin_user.id}, data: {confirm: 'Are you sure?'} %>

#     <%# link_to content_tag(:button, 'Edit' ,:class => "btn btn-default"),{:id => 'myBtn', :action => 'edit', :id => admin_user.id} %>



#    <button data-id="<%=admin_user.id%>" class='myBtn btn btn-default'>Edit Modal Type</button>



#   <%= link_to content_tag(:button, 'Delete' ,:class => "btn btn-default"), { action: 'delete' ,id: admin_user.id}, data: {confirm: 'Are you sure?'}  %>



#       </td>
#      </tr>
#      <% end %>
#     </tbody>
#   </table>




    #
      # Construct a hash from the ActiveRecord result
      return_data = Hash.new()
      return_data[:page] = page
      return_data[:total] = count
      review_results = ""

      return_data[:rows] = @admin_users.collect{|u| {
           :id=> u.id,
            :cell=>[
                '<div style="text-align:center;"><img src='+u.userpic.public_filename(:thumbnail)+'></div>',
                u.username,
                u.name,
                u.email,
               
            ]}}
      
      # Convert the hash to a json object

      render :text=>return_data.to_json, :layout=>false

    end



        def datalist1

    #  thename = params[:name].strip

      thename = params[:namesearch]

      condition_params = ""

      if thename.present?

      condition_params = " (lower(concat(first_name,' ',last_name)) like '%#{thename.downcase}%')"

      end


      page = (params[:page]).to_i

      rp = (params[:rp]).to_i
      sortname = params[:sortname]
      sortorder = params[:sortorder]
      if (!sortname)
        sortname = "businesses.business_name"
      end
      if (!sortorder)
        sortorder = "asc"
      end
      if (!page)
        page = 1
      end
      if (!rp)
        rp = 15
      end
      start = ((page-1) * rp).to_i



     
    #   @businesses = Business.find(:all,
    #       #:joins => "LEFT JOIN premium_listings on (premium_listings.business_id=businesses.id and premium_listings.pl_status='active')",
    #       :order => sortname+' '+sortorder,
    #       #:group => "businesses.id,businesses.business_name,businesses.trade_name",
    #       :limit =>rp,
    #       :offset =>start,
    #       :select => "  businesses.id,businesses.business_name,businesses.trade_name,
    #       businesses.permalink,businesses.unit_no,
    #  businesses.building_name,businesses.street_no,
    #  businesses.street_name,businesses.village,businesses.barangay,
    #  (select display_name from locations where id=businesses.location_id) as location_name, businesses.zip_code",
    #       :conditions=>condition_params)
    # count = Business.count(:all,
    #     :conditions=>condition_params)



    #@admin_users = AdminUser.sorted
    @admin_users = AdminUser.find(:all,
          :conditions=>condition_params)


      # @banner_ads = Business.find(:all,
      #          :joins => "join banner_ads on businesses.id=banner_ads.business_id",
      #          :order => sortname+' '+sortorder,
      #          :limit =>rp,
      #          :offset =>start,
      #          :select => " businesses.id,businesses.business_name, businesses.trade_name, businesses.permalink,
      #                       banner_ads.id as banner_id, banner_ads.business_contract_no , banner_ads.file_name, banner_ads.ad_url, banner_ads.ad_keyword, banner_ads.ad_location, banner_ads.impressions, banner_ads.start_date, banner_ads.expiry_date",
      #          :conditions=>condition_params)



    count = AdminUser.count(:all,  
             :conditions=>condition_params)       
# <table class="table">
#     <thead>
#     <tr>
    
#       <th style="border-top-left-radius: 10px;">Picture</th>
#       <th>Username</th>
#       <th>Name</th>
#       <th>Email</th>
#       <th style="border-top-right-radius: 10px;width:150px;">Actions</th>
#      </tr>
#     </thead>
#     <tbody>
#        <% @admin_users.each do |admin_user| %>
#      <tr class="<%= cycle('odd', 'even')%>" >
#       <%# image_tag(thepostcard.public_filename(:thumbnail)) %>
#       <%# image_tag(admin_user.userpic.public_filename()) %>
#       <%# admin_user.userpic %>
#       <td style="text-align: center;"><%= image_tag(admin_user.userpic.public_filename(:thumbnail)) %></td>
#       <td><%= admin_user.username %></td>
#       <td><%= admin_user.name %></td>
#       <td><%= mail_to(admin_user.email) %></td>
#       <td style="width:120px;">
#       <%# link_to('Edit', {:action => 'edit', :id => admin_user.id}, :class => 'action edit') %>
#       <%# link_to('Delete', {:action => 'delete', :id => admin_user.id}, :class => 'action delete') %>

#     <%# link_to 'Delete', { action: 'delete' ,id: admin_user.id}, data: {confirm: 'Are you sure?'} %>

#     <%# link_to content_tag(:button, 'Edit' ,:class => "btn btn-default"),{:id => 'myBtn', :action => 'edit', :id => admin_user.id} %>



#    <button data-id="<%=admin_user.id%>" class='myBtn btn btn-default'>Edit Modal Type</button>



#   <%= link_to content_tag(:button, 'Delete' ,:class => "btn btn-default"), { action: 'delete' ,id: admin_user.id}, data: {confirm: 'Are you sure?'}  %>



#       </td>
#      </tr>
#      <% end %>
#     </tbody>
#   </table>


    #
      # Construct a hash from the ActiveRecord result
      return_data = Hash.new()
      #return_data = @admin_users
  #admin_users.userpic.public_filename(:thumbnail)
    

      
      return_data = @admin_users.collect{|u| {
           :id=> u.id,
           :image=>u.userpic.public_filename(:thumbnail),
           :username=>u.username,
           :name=> u.first_name + ' ' + u.last_name,
           :email=> u.email


            }}

      # Convert the hash to a json object

      render :text=>return_data.to_json, :layout=>false

    end




def export

 #  headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = "attachment; filename=admin_users"+Time.now.to_date.to_s+".xls"
    headers['Cache-Control'] = ''

    @admin_users = AdminUser.sorted
    count = AdminUser.count(:all)   

  respond_to do |format|
      format.html{render :content_type => 'application/vnd.ms-excel', layout: false }
  end


end













end
