class SectionEdit < ActiveRecord::Base
  attr_accessible :editor, :section, :summary
  belongs_to :editor, :class_name => "AdminUser", :foreign_key => 'admin_user_id'
  belongs_to :section
end
