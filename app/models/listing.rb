class Listing < ActiveRecord::Base
  nilify_blanks :types => [:text]
  belongs_to :agent
  belongs_to :branch
  has_many :media

  validates :agent_id, presence: true, numericality: { only_integer: true }
  validates :branch_id, presence: true, numericality: { only_integer: true }
  validates :age_id, presence: true, numericality: { only_integer: true }
  validates :availability_id, presence: true, numericality: { only_integer: true }
  validates :department_id, presence: true, numericality: { only_integer: true }
  validates :frequency_id, presence: true, numericality: { only_integer: true }, if: :is_to_let?
  validates :qualifier_id, presence: true, numericality: { only_integer: true }, if: :is_for_sale?
  validates :sale_type_id, presence: true, numericality: { only_integer: true }, if: :is_for_sale?
  validates :style_id, presence: true, numericality: { only_integer: true }
  validates :tenure_id, presence: true, numericality: { only_integer: true }, if: :is_for_sale?
  validates :type_id, presence: true, numericality: { only_integer: true }

  validates :address_1, presence: true, length: { in: 3..50 }
  validates :address_2, length: { in: 0..50 }
  validates :address_3, length: { in: 0..50 }
  validates :address_4, length: { in: 0..50 }
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
  validates :price, presence: true, numericality: true, if: :is_for_sale?
  validates :price_on_application, presence: true, inclusion: [true, false], if: :is_for_sale?
  validates :development, presence: true, inclusion: [true, false], if: :is_for_sale?
  validates :investment, presence: true, inclusion: [true, false], if: :is_for_sale?
  validates :estimated_rental_income, presence: true, numericality: true, if: :is_for_sale?
  validates :rent, presence: true, numericality: true, if: :is_to_let?
  validates :rent_on_application, presence: true, inclusion: [true, false], if: :is_to_let?
  validates :student, presence: true, inclusion: [true, false], if: :is_to_let?
  validates :featured, presence: true, inclusion: [true, false]
  validates :status, presence: true, numericality: { only_integer: true }

  def is_for_sale?
    department_id == 1
  end

  def is_to_let?
    department_id == 2
  end

end
