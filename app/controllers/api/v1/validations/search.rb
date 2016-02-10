module Api::V1::Validations
  class Search
    include ActiveModel::Validations

    attr_accessor :department, :latitude, :longitude,
    :distance, :min_beds, :max_beds, :type, :page, :size

    validates :department, numericality: {
      :greater_than_or_equal_to => 1,
      :less_than_or_equal_to => 2
    }
    validates :latitude, presence: true, numericality: true
    validates :longitude, presence: true, numericality: true
    validates :distance, presence: true, numericality: true
    validates :min_beds, presence: true, numericality: { only_integer: true }
    validates :max_beds, presence: true, numericality: { only_integer: true }
    validates :type, presence: true, numericality: { only_integer: true }
    validates :page, presence: true, numericality: { only_integer: true }
    validates :size, presence: true, numericality: { only_integer: true }

    def initialize(params={})
      @department = params[:department]
      @latitude = params[:latitude]
      @longitude = params[:longitude]
      @distance = params[:distance]
      @min_beds = params[:min_beds]
      @max_beds = params[:max_beds]
      @type = params[:type]
      @page = params[:page]
      @size = params[:size]
      ActionController::Parameters.new(params).permit(
        :department, :latitude, :longitude,
        :distance, :min_beds, :max_beds, :type,
        :page, :size
      )
    end

  end
end
