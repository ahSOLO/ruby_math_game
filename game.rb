require "./player"
require "./question"

class Game
  # Game States
  ASK_QUESTION = 0
  EVALUATE_ANSWER = 1
  PRINT_SCORE = 2
  ADVANCE_TURN = 3

  attr_accessor :game_state, :current_player, :answer, :player_1, :player_2, :question, :active

  def initialize
    self.game_state = ASK_QUESTION
    self.answer = ""
  end

  # Start the game
  def start
    self.player_1 = Player.new("Player 1")
    self.player_2 = Player.new("Player 2")
    self.current_player = self.player_1
    self.active = true
    while self.active
      self.update
    end
  end

  protected

  # Main Game Loop
  def update
    case game_state
    when ASK_QUESTION
      self.question = Question.new
      puts "#{self.current_player.name}: What does #{self.question.num1} plus #{self.question.num2} equal?"
      self.answer = gets.chomp
      self.game_state = EVALUATE_ANSWER
    when EVALUATE_ANSWER
      if self.answer.to_i == self.question.sum
        puts "#{self.current_player.name}: YES! You are correct."
      else
        puts "#{self.current_player.name}: Seriously? No!"
        self.current_player.life -= 1
      end
      self.game_state = PRINT_SCORE
    when PRINT_SCORE
      puts "P1: #{self.player_1.life}/3 vs P2: #{self.player_2.life}/3"
      self.game_state = ADVANCE_TURN
    when ADVANCE_TURN
      # Check for winners and end game if found
      if self.current_player.life <= 0
        winner = (self.current_player == self.player_1) ? self.player_2 : self.player_1
        puts "#{winner.name} wins with a score of #{winner.life}/3"
        puts "----- GAME OVER -----"
        puts "Good bye!"
        self.active = false
      end
      # Set current player to the other player and restart the loop
      self.current_player = (self.current_player == self.player_1) ? self.player_2 : self.player_1 
      self.game_state = ASK_QUESTION
    end
  end
end