class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :email, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # has_one :role, :class_name => "Role", :foreign_key => 'role_id', :validate => true
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_attached_file :avatar, 
  :path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
  :url => "/system/:attachment/:id/:basename_:style.:extension",
  :styles => {
    :thumb    => ['100x100#',  :jpg, :quality => 70],
    :preview  => ['480x480#',  :jpg, :quality => 70],
    :large    => ['600>',      :jpg, :quality => 70],
    :retina   => ['1200>',     :jpg, :quality => 30]
  },
  :convert_options => {
    :thumb    => '-set colorspace sRGB -strip',
    :preview  => '-set colorspace sRGB -strip',
    :large    => '-set colorspace sRGB -strip',
    :retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
  }
  validates_attachment :avatar,
  :presence => true,
  :size => { :in => 0..10.megabytes },
  :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }

end
