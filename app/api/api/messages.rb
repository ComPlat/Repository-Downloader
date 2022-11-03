module API
  class Messages < Grape::API
    resource :messages do
      desc "Return list of messages"
      get do
        messages = Message.all
        present messages
      end

      desc "Return a message"
      params do
        requires :id, type: Integer, desc: "Message ID"
      end
      route_param :id, type: Integer do
        get do
          Message.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          error!("Message not found", 404)
        end
      end
    end
  end
end
