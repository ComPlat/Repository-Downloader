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
          present messages[params[:id]]
        end

        def test_message
          [{"title" => "hello", "body" => "how are you"}, {"title" => "goodbye", "body" => "see you soon"}]
        end
      end
    end
  end
end
