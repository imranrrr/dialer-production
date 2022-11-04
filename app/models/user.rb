class User < ApplicationRecord

  belongs_to :group
  belongs_to :role

  has_many :dialstousers, dependent: :restrict_with_error
  has_many :dials, through: :dialstousers, dependent: :restrict_with_error

  before_create :generate_auth_secret
  validates :phone, presence: {:message => I18n.t('global.errors.phone_presence')}
  validates :phone, uniqueness: {:message => I18n.t('global.errors.phone_taken')}
  validates :phone1, uniqueness: {:message => I18n.t('global.errors.phone_taken')}
  validates :phone2, uniqueness: {:message => I18n.t('global.errors.phone_taken')}

  validates :phone, uniqueness: { scope: :phone1, :message => I18n.t('global.errors.phone_taken')}
  validates :phone1, uniqueness: { scope: :phone, :message => I18n.t('global.errors.phone_taken')}
  validates :phone1, uniqueness: { scope: :phone2, :message => I18n.t('global.errors.phone_taken')}
  validates :phone2, uniqueness: { scope: :phone, :message => I18n.t('global.errors.phone_taken')}
  validates :phone2, uniqueness: { scope: :phone1, :message => I18n.t('global.errors.phone_taken')}
  
  def self.allow_user_list(user)
    User.where(group: user.group.descendants).or(User.where(group: user.group)).order(id: :desc)
  end

  scope :active?, ->(state) { where(active: state) }  
  scope :search_in_all_fields, ->(text){
    where(
      column_names
        .map {|field| "#{field} like '%#{text}%'" }
        .join(" or ")
    )
  }

  validates :phone,
    numericality: {only_integer: true},
    format: { with: /998(\d{9})/,
    message: I18n.t('global.errors.phone_format')}

  validates :phone1,
    allow_blank: false,
    numericality: {only_integer: true},
    format: { with: /998(\d{9})/,
    message: I18n.t('global.errors.phone_format')}

  validates :phone2,
    allow_blank: false,
    numericality: {only_integer:true},
    format: { with: /998(\d{9})/,
    message: I18n.t('global.errors.phone_format')}

  validates :fio, :rank, :role, :group, presence: {:message => I18n.t('global.errors.shold_be_filled')}

  validates :rank, inclusion: { in: Rails.configuration.set[:ranks] , message: I18n.t('global.errors.rank_list') }
  validates :pincode, numericality: {only_integer: true, message: I18n.t('global.errors.digit_only') }
  validates :pincode, length: {minimum: 2, maximum: 6, message: I18n.t('global.errors.pin_length')}

  def self.generate_auth_salt
    ROTP::Base32.random(16)
  end

  def auth_code(salt)
    totp(salt).now
  end

  def valid_auth_code?(salt, code)
    # 5mins validity
    totp(salt).verify(code, drift_behind: 300).present?
  end

  private

  # This is used as a secret for this user to 
  # generate their OTPs, keep it private.
  def generate_auth_secret
    self.auth_secret = ROTP::Base32.random(16)
  end

  def totp(salt)
    ROTP::TOTP.new(auth_secret + salt, issuer: "Dialer")
  end
end
