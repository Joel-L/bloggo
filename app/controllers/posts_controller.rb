class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create 
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Grood! Your journey to the Bloggo-side is deepening with each post"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy 
    @post.destroy
    flash[:success] = "Bloggo...deleted. It was only a fool's hope, as I have been reminded"
    redirect_to request.referrer || root_url
  end

  private 
    def post_params
      params.require(:post).permit(:content, :title, :picture)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
