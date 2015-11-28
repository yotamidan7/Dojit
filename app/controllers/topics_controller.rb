class TopicsController < ApplicationController
  def index
    #@topics = Topic.all

    if params.has_key?(:page)
      @page = params[:page]
    else
      @page = 0
    end

    puts "Page = "
    puts @page

    @topics = Topic.mypagination(page: @page, per_page: 10)[:results]
    @batch_count = Topic.mypagination(page: @page, per_page: 10)[:batch_count]  

    authorize @topics

  end

  def show

    if params.has_key?(:page)
      @page = params[:page]
    else
      @page = 0
    end

    @topic = Topic.find(params[:id])
    @posts = @topic.posts.mypagination(page: @page, per_page: 10)[:results]
    @batch_count = @topic.posts.mypagination(page: @page, per_page: 10)[:batch_count]
    authorize @topic
  end

  def new
    @topic = Topic.new
    authorize @topic
  end 

  def create
    @topic = Topic.new(topic_params)
    authorize @topic
    if @topic.save
      flash[:notice] = "Topic was saved."
      redirect_to @topic
    else
      flash[:error] = "There was an error saving the topic. Please try again."
      render :new
    end 
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic
    if @topic.update_attributes(topic_params)  
      redirect_to @topic
    else
      flash[:error] = "There was an error updating the topic. Please try again."
      render :edit
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end
end
