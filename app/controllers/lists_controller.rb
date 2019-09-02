class ListsController < ApplicationController
  before_action :set_board
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  
  def index
    @lists = List.all_lists(@board.id)
  end

  def show
  end

  def new
    @list = @board.lists.new
  end

  def create
    list.create_list(list_params, @board.id)
    redirect_to board_lists_path
  end

  def edit
  end

  def update
    list.update_list(@list.id, list_params)
  end

  def destroy
    list.delete_list(@list.id,)
    redirect_to board_lists_path
  end

  private
    def set_board
      @board = Board.find(params[:board_id])
    end

    def set_list
      @list = List.single_list(:board.id, params[:id])
    end

    def list_params
      params.require(:list).permit(:name)
    end
end
