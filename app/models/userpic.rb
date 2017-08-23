class Userpic < ActiveRecord::Base

  attr_accessible :admin_user_id,:uploaded_data
  belongs_to :admin_user

  has_attachment :content_type => :image,
  				 :storage => :file_system,
  				 :max_size => 2.megabyte,
  				 :resize_to => '320x200>',
  				 :thumbnails => { 
  				 	:thumbnail => '100x100>'}
  				 

  validates_as_attachment
 


end
