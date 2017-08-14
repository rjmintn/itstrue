class WikisController < ApplicationController

  before_action :find_id, only: [:show, :edit, :update, :destroy]
  #after_action :show_coll, only: [:edit]
  # before_action :add_collaborator, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_user, only: :show
  #before_action :find_collaborators, only: :show

  # before_action :authorize @wiki

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    authorize @wiki
    # @user.wikis << Wiki.find(wiki_id)
    # @wiki.users << User.find(current_user)
  end

  def new

    @wiki = Wiki.new
    # @user = @wiki.users
    # @collab = @wiki.collaborators
    # puts @wiki.collaborators.empty?
    # puts @users
    #@wiki.collaborators = collaborators
    #puts @wiki.users
    # @user = @wiki.users
    # authorize @wiki
    # puts 'hello'
    #puts @wiki.users.find(2)
    #@wiki.users = users
    #@wiki.collaborators = collaborators
  end

  def create

    @wiki = current_user.wikis.new(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    authorize @wiki

    # @wiki = Wiki.new
    # @wiki.col_email = "help@me.com"
    # @wiki.col_email = col_email
  end

  def update
    puts "b"
    puts @wiki.col_email
    puts @wiki.title
    puts @wiki.users.exists?(@wiki.col_email)
    # puts @wiki.users.find(email: :col_email)

    puts @wiki.attribute_names
    puts params[:f][:user_ids]
    puts @wiki.private
    puts "a"

    if @wiki.update_attributes(wiki_params)
      puts @wiki.title
      puts :why
      puts @col_email
      flash[:notice] = "Wiki was updated"
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error updating the post. Please try again."
      render :edit
    end
  end

  def destroy
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title} \" was deleted."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    puts "params here"
    params.require(:wiki).permit(:title, :body, :private, :user_ids, :col_email)
  end

  def find_id
    @wiki = Wiki.find(params[:id])
    # @wiki.col_email = col_email
    # puts Wiki.attribute_names

  end

  def find_user
    @user = User.find(@wiki.user_id)
  end

  def add_collaborator
    @collab = []
    @collab = Collaborator.where(:wiki_id => @wiki.id)
  end

  def show_coll
    puts params[:f][:user_ids]
  end

end
