class SheetsController < ApplicationController
  def index
    @sheetsA = Sheet.where(row: 'a')
    @sheetsB = Sheet.where(row: 'b')
    @sheetsC = Sheet.where(row: 'c')
  end

  def show
  end

  def edit
  end

  
end
