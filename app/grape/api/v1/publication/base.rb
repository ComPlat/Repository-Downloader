module API
  module V1
    module Publication
      class Base < Grape::API
        mount API::V1::Publication::Doi
      end
    end
  end
end
