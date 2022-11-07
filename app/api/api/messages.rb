module API
  class Messages < Grape::API
    namespace :messages do
      desc "Return list of messages"
      get do
        messages = API::Messages.test_message
        present messages
      end

      desc "Return a message"
      params do
        requires :id, type: Integer, desc: "Message ID"
      end
      route_param :id, type: Integer do
        get do
          messages = API::Messages.test_message
          error!("Invalid message: #{params[:id]}", 404) unless present messages[params[:id]]
        end
      end

      def test_message
        [{"title" => "hello", "body" => "how are you"}, {"title" => "goodbye", "body" => "see you soon"}]
      end
    end

    route :any, "*path" do
      error!("Not found", 404)
    end
  end
end
