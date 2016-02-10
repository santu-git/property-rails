class Api::V1::CategorizationsController < Api::V1::BaseController
  before_filter :authenticate_user!

  def index
    render json: {
      ages: Age.all.select("id,value"),
      availabilities: Availability.all.select("id,value"),
      departments: Department.all.select("id,value"),
      frequencies: Frequency.all.select("id,value"),
      mediatypes: MediaType.all.select("id,value"),
      qualifiers: Qualifier.all.select("id,value"),
      saletypes: SaleType.all.select("id,value"),
      styles: Style.all.select("id,value"),
      tenures: Tenure.all.select("id,value"),
      types: Type.all.select("id,value"),
    }
  end

end
