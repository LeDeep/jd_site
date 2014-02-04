class Contact < ActiveRecord::Base 
  has_no_table

  column :name, :string 
  column :email, :string 
  column :content, :string
  validates_presence_of :name, :email, :content
  validates_format_of :email,
    :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i 
  validates_length_of :content, :maximum => 500

  def update_spreadsheet
  connect_to_drive = GoogleDrive.login(ENV["GMAIL_USERNAME"], ENV["GMAIL_PASSWORD"]) 
  contact_info = connect_to_drive.spreadsheet_by_title('JDExcel Contacts')
  if contact_info.nil?
    contact_info = connect_to_drive.create_spreadsheet('Contact Information') 
  end
  excel_sheet = contact_info.worksheets[0] 
  last_row = 1 + excel_sheet.num_rows 
  excel_sheet[last_row, 1] = Time.new 
  excel_sheet[last_row, 2] = self.name 
  excel_sheet[last_row, 3] = self.email 
  excel_sheet[last_row, 4] = self.content 
  excel_sheet.save
end

end