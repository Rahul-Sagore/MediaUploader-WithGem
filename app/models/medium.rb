class Medium < ActiveRecord::Base
	mount_uploader :media_file, MediaFileUploader
	belongs_to :users

	# Validation
	validates :user_id, :presence => true
	validates :filename, :presence => true
	validates_associated :users

	def upload_file(file_obj, user_id)    
 		filename = avoid_duplicates(file_obj.original_filename, user_id)
 		# Save the file info into database
 		self[:user_id] = user_id
 		self[:filename] = filename

 		File.open(Rails.root.join('public', 'images/uploads/', user_id.to_s, filename), 'w') do |file|
 			self[:media_file] = file
 		end

 		puts self.inspect
    self.save
	end

	def avoid_duplicates(filename, user_id)
		file_ext = File.extname(filename)
		file_base = File.basename(filename, file_ext)
		is_file_exit = Medium.where(:user_id => user_id, :filename => filename)

		if is_file_exit.size > 0
			more_files_exit = Medium.where(["filename LIKE ?", "%#{file_base}_copy%"]).where(:user_id => user_id)

			if more_files_exit.size > 0
				las_entry = more_files_exit[-1].filename
			else
			 	las_entry = is_file_exit[-1].filename
			end
			ext = File.extname(las_entry)
			f_basename = File.basename(las_entry, ext)
			pat = f_basename.match(/(_copy)[0-9]*/)

			if !pat.nil?
				pat = pat.to_s
				copy = [pat.slice(0..4), pat.slice(5..-1)]
				#Slicng for double digit replcement
				f_basename[-copy[1].size..-1] = (copy[1].to_i + 1).to_s + ext
				f_basename
			else
				f_basename + "_copy1" + ext
			end
		else
			filename
		end
	end
end
