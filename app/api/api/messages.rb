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
      get do
        Message.find(params[:id])
      end

      desc "Create a message"
      params do
        requires :title, type: String, desc: "Message title"
        requires :content, type: String, desc: "Message content"
      end
      post do
        Message.create(title: params[:title], content: params[:content])
      end

      desc "Update a message"
      params do
        requires :id, type: String, desc: "Message ID"
        requires :title, type: String, desc: "Message title"
        requires :content, type: String, desc: "Message content"
      end
      post do
        Message.find(params[:id]).update(title: params[:title], content: params[:content])
      end

      desc "Delete a message"
      params do
        requires :id, type: Integer, desc: "Message ID"
      end
      delete ":id" do
        Message.find(params[:id]).destroy
      end
    end
  end
end
