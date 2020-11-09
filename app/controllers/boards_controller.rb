class BoardsController < ApplicationController
  def index
  end

  def new
    @board = Board.new
  end

  def create
    clean_params = params.require(:board).permit(:title)
    @board = Board.new(clean_params)
    if @board.save
      redirect_to "/", notice: '成功新增看板'
    else
      render :new
    end
  end
end
