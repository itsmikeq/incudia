module BroadcastMessagesHelper
  def broadcast_styling(broadcast_message)
    if(broadcast_message.color || broadcast_message.font)
      "background-color:#{broadcast_message.color};color:#{broadcast_message.font}"
    else
      # Default
      "background-color:#FFCACA;color:#222222"
    end
  end
end
