#### MOUSE RACER SPEC

require 'mocha/setup'
require './lib/mouse_class.rb'
require './lib/board_class.rb'


describe '#mouse_class' do

  before(:each) do

  end


  it 'should find a start point on the left' do
    board = Board.new
    board.create_maze("./data/maze.rb")
    board.set_open(" ")
    mouse1 = Mouse.new(board)

    mouse1.set_left_start_point

    expect(mouse1.y_position).to eq(3)
  end

  it "should recognize [0,0] as only having two valid neighbors" do
    board = Board.new
    board.create_maze("./data/maze.rb")
    board.set_open(" ")
    mouse1 = Mouse.new(board)
    mouse1.set_left_start_point
    mouse1.stub(:x_position){0}
    mouse1.stub(:y_position){0}

    expect(mouse1.valid_positions.length).to eq(2)
  end


end