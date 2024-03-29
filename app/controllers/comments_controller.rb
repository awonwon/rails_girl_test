class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

      if @comment.save
        #flash[:test] = comment_params[:idea_id]
        redirect_to idea_path(Idea.find(comment_params[:idea_id]))
        #format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @comment }
      else
        #format.html { render action: 'new' }
        #format.json { render json: @comment.errors, status: :unprocessable_entity }
      end

  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @idea = Idea.find(@comment.idea_id)
    @comment.destroy
    flash[:delete_comment] = 'Delete comment successfully!'
    respond_to do |format|
      format.html { redirect_to idea_path(@idea) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_name, :body, :idea_id)
    end
end
