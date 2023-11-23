class CommentsController < ApplicationController
  before_action :set_comment, only: %w(show edit update destroy)
  before_action :authorize_section, only: %i[index show new create edit update destroy]

  def index
  end

  def new
    @comment = Comment.new    
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to comments_path
    else
      render :new
    end
  end

  def update  
  end

  private  

  def authorize_section
    authorize :Comment
  end

  def set_comment
    @comment = Comment.find(params.fetch(:id))
  end

end
