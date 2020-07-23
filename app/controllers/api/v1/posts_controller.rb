module Api
  module V1
    class PostsController < ApplicationController


      api :GET, '/v1/posts', 'ユーザ一覧を返しますyoyoyo'
      # エラーの指定はこのような形で
      error code: 401, desc: 'Unauthorized'
      error code: 404, desc: 'Not Found'
    
      # 利用例は example に記載
      example <<-EDOC
      $ curl http://localhost:3000/posts/
            [
              {
                "id": 1,
                "created_at": "2017-12-21T13:06:56.966Z",
                "updated_at": "2017-12-21T13:06:56.966Z",
                "name": "サンプルユーザ1"
              },
              {
                "id": 2,
                "created_at": "2017-12-21T13:06:56.966Z",
                "updated_at": "2017-12-21T13:06:56.966Z",
                "name": "サンプルユーザ2"
              }
            ]
      EDOC




      before_action :set_post, only: [:show, :update, :destroy]
      # skip_before_action :verify_authenticity_token

      def index
        posts = Post.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'Loaded posts', data: posts }
      end

      def show
        render json: { status: 'SUCCESS', message: 'Loaded the post', data: @post }
      end

      def create
        post = Post.new(post_params)
        if post.save
          render json: { status: 'SUCCESS', data: post }
        else
          render json: { status: 'ERROR', data: post.errors }
        end
      end

      def destroy
        @post.destroy
        render json: { status: 'SUCCESS', message: 'Deleted the post', data: @post }
      end

      def update
        if @post.update(post_params)
          render json: { status: 'SUCCESS', message: 'Updated the post', data: @post }
        else
          render json: { status: 'SUCCESS', message: 'Not updated', data: @post.errors }
        end
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title)
      end
    end
  end
end