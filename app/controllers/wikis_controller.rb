class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(wiki_params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
  end

  def update

    if @wiki.save
      flash[:notice] = "Wiki was updated"
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error updating the post. Please try again."
      render :edit
    end
  end

  def destroy
  end

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end