class Medium < ActiveRecord::Base
	mount_uploader :media_file, MediaFileUploader
	belongs_to :users
end
