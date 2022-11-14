module API
  module V1
    module Publications
      class Base < Grape::API
        mount API::V1::Publications::Doi
      end
    end
  end
end
