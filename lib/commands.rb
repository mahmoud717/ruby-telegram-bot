require 'httparty'
class Commands
  def initialize(message, bot)
    @message = message
    @bot = bot
  end

  def start_respond
    text = "Hello, #{@message.from.first_name} \nI'm the Randomizer bot. to see the list of available commands type /commands"
    text
  end

  def stop_respond
    text = "Bye, #{@message.from.first_name}. \nI hope we meet again."
    text
  end

  def greet_respond
    greetings = %w[bonjour hola hallo sveiki namaste salaam szia halo ciao].sample.capitalize
    text = "#{greetings}, #{@message.from.first_name}."
    text
  end

  def commands_respond
    commands = "/greet :- To send a random greeting. \n/commands :- To show available commands. \n/gif :- To display a random gif meme. \n/quote :- To display a random quote. \n/joke :- To display a random Joke\n/dice :- to do a dice roll"
    text = "The available commands are: \n #{commands}"
    text
  end

  def gif_respond
    response = HTTParty.get('https://api.tenor.com/v1/trending?key=2SZQ8K1GM7CN&media_filter=minimal&ar_arange=standerd&limit=20')
    gifs = []
    response['results'].map do |el|
      gifs << el['media'][0]['gif']['url']
    end
    animation = gifs.sample
    animation
  end

  def dice_respond
    text = (1..6).to_a.sample
    text
  end

  def quote_respond
    response = HTTParty.get('https://favqs.com/api/qotd', headers: {
                              'Authorization' => 'Token token=4f18598c7ede67654748830c993cca79'
                            })
    author = response['quote']['author']
    quote = response['quote']['body']
    text = "#{quote} \n #{author}"
    text
  end

  def joke_respond
    response = HTTParty.get('https://official-joke-api.appspot.com/jokes/general/random')
    setup = response[0]['setup']
    punchline = response[0]['punchline']
    text = "#{setup}\n#{punchline}"
    text
  end

  def unknown_respond
    text = "I don't know what '#{@message.text}' is...\nTo see the list of available commands type '/commands'"
    text
  end
end
