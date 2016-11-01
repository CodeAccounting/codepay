class BackgroundImage < ActiveRecord::Base
	belongs_to :user

	validates :user_id, uniqueness: true

	has_attached_file :file, styles: { cover: "1180x359#", thumb: "150x150>" },
                             				 default_url: "/assets/default-background.jpg"
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
  before_post_process :rename_file

  def rename_file
    extension = File.extname(file_file_name).downcase
    self.file.instance_write :file_name, "#{Time.now.to_i.to_s}#{extension}"
  end
end
