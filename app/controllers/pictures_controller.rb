require 'pry'
require 'paperclip'
require 'aws-sdk-s3'
class PicturesController < ApplicationController
    http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

    def create
        @article = Article.find(params[:article_id])
        @picture = @article.pictures.create(picture_params)
        flash[:success] = "Picture was successfully posted!"
        redirect_to article_path(@article)
    end

    def destroy
        @article = Article.find(params[:article_id])
        @picture = @article.pictures.find(params[:id])
        @picture.destroy
        
        redirect_to article_path(@article), status: :see_other
        flash[:success] = "Picture was successfully erased!"
    end

    private
    
    def picture_params
        params.require(:picture).permit(:id, :article_id, :picture_file_name, :picture_content_type, :picture_file_size, :picture_updated_at)
    end
end





