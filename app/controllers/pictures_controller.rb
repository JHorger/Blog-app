class PicturesController < ApplicationController
    http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

    def create
        @article = Article.find(params[:article_id])
        @picture = @article.picture.url
        redirect_to article_path(@article)
    end


    private
    
    def picture_params
        params.require(:picture).permit(:article_id)
    end
end
