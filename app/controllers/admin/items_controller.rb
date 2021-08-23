class Admin::ItemsController < ApplicationController
  def index
   @items = Item.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item= Item.new(item_params)
    if @item.save
      flash[:notice] = "新商品を登録しました。"
      redirect_to admin_item_path(@item)
    else
      @genres = Genre.all
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end


  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "商品の内容を変更しました。"
      redirect_to admin_item_path
    else
      render 'edit'
    end
  end

  def destroy
    @item =Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :genre_id, :price, :is_active)
  end
end
