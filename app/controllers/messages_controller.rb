class MessagesController<ApplicationController
    def index
        @messages=Message.all
    end
    def show
        @messages=Message.find(params[:id])
    end
end