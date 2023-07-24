require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
  describe 'iteration 3' do
    let(:game) {Game.new}
  
    it 'exists' do
      expect(game).to be_a(Game)
      game.start
    end
    
  end

end
