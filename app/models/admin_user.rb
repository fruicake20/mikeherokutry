require 'digest/sha1'
class AdminUser < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :username, :email , :password, :profile_pic
  #, :password_confirmation
  
  has_one :userpic
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits

  attr_accessor :password
  attr_accessor :profile_pic
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i


#Standard Validation Methods
=begin
  validates_presence_of :first_name
  validates_length_of :first_name, :maximum => 25
  validates_presence_of :last_name
  validates_length_of :last_name, :maximum => 50
  validates_presence_of :username
  validates_length_of :username, :within => 8..25
  validates_uniqueness_of :username
  validates_presence_of :email
  validates_length_of :email, :maximum => 100
  validates_format_of :email, :with => EMAIL_REGEX
  validates_confirmation_of :email

after_save :save_profile_pic_image, if: :profile_pic
 def save_profile_pic_image
    filename = profile_pic.original_filename
    folder = "public/users/profile_pic"

    FileUtils::mkdir_p folder

    f = File.open File.join(folder, filename), "wb"
    f.write profile_pic.read()
    f.close

    self.profile_pic= nil
    update profile_pic_filename: filename
  end


=end

#New Clearer Validations
# validates :first_name, :presence => true, :length => {:maximum => 25}
# validates :last_name, :presence => true, :length => {:maximum => 50}
# validates :username, :length => {:within => 8..25}, :uniqueness => true
# validates :email, :presence => true, :length => { :maximum => 100}, :format => EMAIL_REGEX, :confirmation => true
# #validates :password, :confirmation => true

# validates_length_of :password, :within => 8..25, :on => :create, :on => :update, :confirmation => true

before_save :create_hashed_password
after_save :clear_password

#mount_uploader :profile_pic, 


  scope :named, lambda {|first,last| where(:first_name => first, :last_name => last)}
  scope :sorted, order("admin_users.last_name ASC, admin_users.first_name ASC")
  

  attr_protected :hashed_password, :salt

 


  def name
    "#{first_name} #{last_name}"
  end


  def self.authenticate(username="", password="")
  	user = AdminUser.find_by_username(username)
  	
  	if user && user.password_match?(password)
  		return user
  	else
  		return false
  	end

  end

  def password_match?(password="")
  	hashed_password == AdminUser.hash_with_salt(password,salt)
  end

  def self.make_salt(username="")
  	Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make salt")
  end

  def self.hash_with_salt(password="",salt="")
  	Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end

  private

  def create_hashed_password
  	unless password.blank?
  		self.salt = AdminUser.make_salt(username) if salt.blank?
  		self.hashed_password = AdminUser.hash_with_salt(password,salt)
 	 end
 end

 def clear_password
 	self.password= nil
 end



end
