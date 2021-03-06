# Enters a file into the database
class Document < ActiveRecord::Base
  belongs_to :user
  # app/models/document.rb 
  
  # Initializes a spot in the database
  # 
  # @param [Hash] params A collection of parameters.
  def initialize(params = {})
    file = params.delete(:file)
    super
    if file
      self.filename = sanitize_filename(file.original_filename)
      self.content_type = file.content_type
      self.file_contents = file.read
      self.file_size = file.size
    end
  end

private
  
  # Sanitizes the filename
  # 
  # @param [String] filename The name of the file to sanitize.
  # @return [String] The basename of the file.
  def sanitize_filename(filename)
    # http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
    return File.basename(filename)
  end
end
