class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :email, :password, :password_confirmation, :about, :avatar

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true, email: true
  validates :password, presence: true, confirmation: true, on: :create

  has_attached_file :avatar, styles: {medium: "300x300>", profile: "180x180>", thumb: "60x60#"}, default_url: :gravatar_url

  # TODO fix this!!!
  Paperclip.interpolates :gravatar_url do |attachment, style|
    size = nil
    if size_data = attachment.styles[style].first
      p size_data
      if thumb_size = size_data.match(/\d+/).to_a.first
        size = thumb_size.to_i
      end
    end
    attachment.instance.gravatar_url(nil, size)
  end

  has_many :app_ownerships
  has_many :owned_apps, through: :app_ownerships, source: :app
  has_many :app_usages
  has_many :used_apps, through: :app_usages, source: :app
  has_many :endorsements_as_endorser, foreign_key: :endorser_id, class_name: 'Endorsement'
  has_many :endorsements_as_endorsee, foreign_key: :endorsee_id, class_name: 'Endorsement'
  has_many :endorsees, through: :endorsements_as_endorser
  has_many :endorsers, through: :endorsements_as_endorsee

  def gravatar_url(default='monsterid', size=60)
    hash = Digest::MD5.hexdigest(email.downcase.strip)[0..31]
    "http://www.gravatar.com/avatar/#{hash}.jpg?size=#{size}&d=#{CGI::escape(default)}"
  end

  def admin?
    self.name == 'admin' # TODO
  end

  def overall_trust
    0.0 # TODO
  end

  def base_trust
    0.0 # TODO
  end
end
