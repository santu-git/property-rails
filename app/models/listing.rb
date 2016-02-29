class Listing < ActiveRecord::Base
  # Relations
  belongs_to :branch
  belongs_to :age
  belongs_to :availability
  belongs_to :department
  belongs_to :style
  belongs_to :type
  belongs_to :frequency
  belongs_to :qualifier
  belongs_to :sale_type
  belongs_to :tenure

  has_many :assets
  has_many :features
  has_many :flags

  # Validations
  validates :branch, presence: true
  validates :age, presence: true
  validates :availability, presence: true
  validates :department, presence: true
  validates :style, presence: true
  validates :type, presence: true
  validates :address_1, presence: true, length: { in: 3..50 }
  validates :address_2, length: { maximum: 50 }
  validates :address_3, length: { maximum: 50 }
  validates :address_4, length: { maximum: 50 }
  validates :town_city, presence: true, length: { in: 3..50 }
  validates :county, presence: true, length: { in: 3..50 }
  validates :postcode, presence: true, length: { in: 7..10 }
  validates :country, presence: true, length: { in: 3..50 }
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :display_address, presence: true, length: { in: 3..200 }
  validates :bedrooms, presence: true, numericality: true
  validates :bathrooms, presence: true, numericality: true
  validates :ensuites, presence: true, numericality: true
  validates :receptions, presence: true, numericality: true
  validates :kitchens, presence: true, numericality: true
  validates :summary, presence: true
  validates :description, presence: true
  validates :featured, inclusion: [true, false]
  validates :status, presence: true, numericality: { only_integer: true }

  with_options if: :is_to_let? do |let|
    let.validates :frequency, presence: true
    let.validates :rent, presence: true, numericality: true
    let.validates :rent_on_application, inclusion: [true, false]
    let.validates :student, inclusion: [true, false]
  end

  with_options if: :is_for_sale? do |sale|
    sale.validates :qualifier, presence: true
    sale.validates :sale_type, presence: true
    sale.validates :tenure, presence: true
    sale.validates :price_on_application, inclusion: [true, false]
    sale.validates :development, inclusion: [true, false]
    sale.validates :investment, inclusion: [true, false]
    sale.validates :estimated_rental_income, presence: true, numericality: true
    sale.validates :price, presence: true, numericality: true
  end

  # Functions
  nilify_blanks :types => [:text]

  #Geocoder
  reverse_geocoded_by :latitude, :longitude

  def is_for_sale?
    department_id == 1
  end

  def is_to_let?
    department_id == 2
  end

  # Nested Attributes (Nested Forms)
  accepts_nested_attributes_for :features, allow_destroy: true
  accepts_nested_attributes_for :flags, allow_destroy: true
  accepts_nested_attributes_for :assets, allow_destroy: true

  # Scopes
  def self.belongs_to_current_user(current_user)
    self.joins(:branch, :agent).where(
      'agents.user_id = ?', current_user.id
    )
  end

end
