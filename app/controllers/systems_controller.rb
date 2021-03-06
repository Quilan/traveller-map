class SystemsController < ApplicationController
  # def index
  #   @systems = System.order(:row, :col).group_by(&:row)
  #   #TODO: Find better way of doing this.
  #   # @systems = []
  #   # (1..10).each do |row|
  #   #   rowcontent = []
  #   #   (1..8).each do |col|
  #   #     rowcontent << System.find_by_row_and_col(row, col)
  #   #   end
  #   #   @systems << rowcontent
  #   # end



  # end
  def render_popup
    @system = System.find(params[:id])
    render :partial => true
  end
  def edit
    @system = System.find(params[:system_id])
    if @system.gmed_by? current_user
      render :partial => true
    else
      redirect_to controller: :subsectors, action: :index
    end
  end
  def update
    @system = System.find(params[:system_id])
    if @system.gmed_by? current_user
      @system.update_attributes(params[:system])
    else
      redirect_to controller: :subsectors, action: :index
    end
  end
end
