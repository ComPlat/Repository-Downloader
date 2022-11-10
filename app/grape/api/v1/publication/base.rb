module API
  module V1
    module Publication
      class Base < Grape::API
        mount API::V1::Publication::ChemotionId
      end
    end
  end
end
