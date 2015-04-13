class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "A new category is created successfully"
      redirect_to admin_categories_path
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find_by_id params[:id]
  end

  def update
    @category = Category.find_by_id params[:id]
    if @category.update_attributes category_params
      flash[:success] = "Category updated"
      redirect_to admin_categories_path
    else
      render 'edit'
    end
  end

  def destroy
    Category.find_by_id(params[:id]).destroy
    flash[:success] = "Category deleted"
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :avatar)
  end
end
