class CommentsController < ApplicationController
    http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params)
        flash[:success] = "Comment was successfully posted!"
        redirect_to article_path(@article)
    end
    
    def destroy
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        @comment.destroy
        
        redirect_to article_path(@article), status: :see_other
        flash[:success] = "Comment was successfully erased!"
    end

    private
        def comment_params
            params.require(:comment).permit(:commenter, :body, :status)
        end
end
