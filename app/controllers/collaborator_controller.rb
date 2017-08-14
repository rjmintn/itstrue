class CollaboratorsController < ApplicationController

  def new
    @collaborator = Collaborator.new
  end

  def create
    #@wiki_id = Wiki.find(params[:wiki_id])
# user_id is from input user, not current user
    #@user_id = User.find(params[:user_id])
    @collaborator = Collaborator.new
    # @collaborator.user_id =
    # @collaborator.wiki_id =
    # @collaborator.email =
  end

  def edit
    @collaborator = colaborators.build(collaborator_params)
  end

  def update
    @collaborator = colaborators.build(collaborator_params)
  end

  private

  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id)

  end

end
