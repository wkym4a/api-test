module Api
  module V1

    class TestController < ApplicationController
      api :GET, '/users/:id', '指定のIDのユーザ情報を返します'
      description '指定のIDのユーザ情報を返します'
      formats ['json']
      error 401, 'Unauthorized'
      error code: 404, description: 'Not Found'
    
      # パラメータ情報に加えて、簡単なバリデーションもapipie側で実施してくれます
      param :id, :number, desc: 'user id', required: true
    
      example <<-EDOC
      $ curl http://localhost:3000/users/
    
            {
              "id": 2,
              "created_at": "2017-12-21T13:06:56.966Z",
              "updated_at": "2017-12-21T13:06:56.966Z",
              "name": "サンプルユーザ2"
            }
      EDOC
      # まだこのapiのドキュメントを表示させたくない場合は show false を指定
      # show false
      def index
        tests = Test.order(created_at: :desc)
        render json: { status: 'SUCCESS', message: 'Loaded posts', data: tests }
      end
    end

  end
end