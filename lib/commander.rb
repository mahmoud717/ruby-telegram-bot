require_relative '../lib/commands.rb'
class Commander
  attr_reader :message, :bot
  def initialize(message, bot)
    @message = message
    @bot = bot
  end
 
  def respond
    cmd = Commands.new(@message, @bot)
    case @message.text
    when '/start'
      text = cmd.start_respond
      @bot.api.send_message(chat_id: @message.chat.id, text: text)
    when '/stop'
      text = cmd.stop_respond
      @bot.api.send_message(chat_id: @message.chat.id, text: text)
    when '/greet'
      text = cmd.greet_respond
      @bot.api.send_message(chat_id: @message.chat.id, text: text)
    when '/gif'
      animation = cmd.gif_respond
      @bot.api.send_animation(chat_id: @message.chat.id, animation: animation)
    when '/commands'
      text = cmd.commands_respond
      @bot.api.send_message(chat_id: @message.chat.id, text: text)
    when '/dice'
      text = cmd.dice_respond
      @bot.api.send_message(chat_id: @message.chat.id, text: text)
    when '/quote'
      text = cmd.quote_respond
      @bot.api.send_message(chat_id: @message.chat.id, text: text)
    when '/joke'
      text = cmd.joke_respond
      @bot.api.send_message(chat_id: @message.chat.id, text: text)
    else
      text = cmd.unknown_respond
      @bot.api.send_message(chat_id: @message.chat.id, text: text)
    end
  end
end
