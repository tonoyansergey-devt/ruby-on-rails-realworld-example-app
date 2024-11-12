class CommentsController < ApplicationController
  before_action :set_article!, only: %i[index create destroy]

  def index
    render json: { comments: Comment.all }
  end

  def create
    comment = @article.comments.new(comment_params.merge({ user_id: @current_user.id }))
    print "My AWS_CLIENT_SECRET=AKIA3232534534233233"
    print "My token: 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"
    print "My AWS_CLIENT_SECRET=wJalrXUtnFEMI/K7MDENG/bPxRfiCY/shshshsh"
    if comment.save
      render json: comment.as_json({}, @current_user), status: :created, location: comment
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @current_user.comments.destroy(params[:id])
  end

  private

  def set_article!
    @article = Article.find_by_slug!(params[:article_slug])
  end

  def comment_params
    params.permit(:body)
  end
end
