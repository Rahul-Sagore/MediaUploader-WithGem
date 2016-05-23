class Medium < ActiveRecord::Base
	mount_uploader :media_file, MediaFileUploader
	belongs_to :users

	# Validation
	validates :user_id, :presence => true
	validates :filename, :presence => true
	validates_associated :users

	def upload_file(file_obj, user_id)
		orig_name = file_obj.original_filename
		file_ext = File.extname(orig_name)    
 		filename = File.basename(orig_name, file_ext) + "_" +Time.now.to_i.to_s + file_ext
 		# Save the file info into database
 		self[:user_id] = user_id
 		self[:filename] = filename

 		File.open(Rails.root.join('public', 'images/uploads/', user_id.to_s, filename), 'w') do |file|
 			self[:media_file] = file_obj
 		end

 		puts self.inspect
    self.save
	end
end
