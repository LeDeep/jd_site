class Contact < ActiveRecord::Base 
  has_no_table

  column :name, :string 
  column :email, :string 
  column :content, :string
  validates_presence_of :name, :email, :content
  validates_format_of :email,
    :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i 
  validates_length_of :content, :maximum => 500

end