class SubsectorsController < ApplicationController
  def index
    @subsectors = Subsector.all
  end

  def show
    @subsector = Subsector.find params[:id]
    @systems = @subsector.systems.order(:row, :col).group_by(&:row)
  end
end
