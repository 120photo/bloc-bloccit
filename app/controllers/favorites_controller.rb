class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)

    authorize favorite

    if favorite.save
      flash[:notice] = "Added to favorites"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "We could not add to your favorites, try again"
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])

    authorize favorite

    if favorite.destroy
      flash[:notice] = "Favorite was removed"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Nope, try again"
      redirect_to [@post.topic, @post]
    end
  end
end
