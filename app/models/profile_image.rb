class ProfileImage < ActiveRecord::Base
	belongs_to :user

	has_attached_file :file, styles: { thumb: "150x150>", avatar: "80x80#" },
                             				 default_url: "/assets/default-avatar.jpg"
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
  before_post_process :rename_file

  def rename_file
    extension = File.extname(file_file_name).downcase
    self.file.instance_write :file_name, "#{Time.now.to_i.to_s}#{extension}"
  end
end
