module API
  class Messages < Grape::API
    resource :messages do
      desc "Return list of messages"
      get do
        messages = Message.all
        present messages
      end
    end
  end
end
