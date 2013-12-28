class SystemsController < ApplicationController
  def index
    #TODO: Find better way of doing this.
    @systems = []
    (1..10).each do |row|
      rowcontent = []
      (1..8).each do |col|
        rowcontent << System.find_by_row_and_col(row, col)
      end
      @systems << rowcontent
    end
    


  end
  def render_popup
    @system = System.find(params[:system_id])
    render :partial => true
  end
end
