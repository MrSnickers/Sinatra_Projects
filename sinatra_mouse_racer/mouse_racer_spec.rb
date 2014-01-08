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
    mouse1.stub(:x_position){0}
    mouse1.stub(:y_position){0}

    expect(mouse1.valid_positions.length).to eq(2)
  end

  it "should recognize an open position in its neighbors" do
    board = Board.new
    board.create_maze("./data/maze.rb")
    board.set_open(" ")
    mouse1 = Mouse.new(board)
    mouse1.stub(:x_position){1}
    mouse1.stub(:y_position){1}

    expect(mouse1.find_open_positions.length).to eq(2)
  end

  it "should recognize a visited square as not being an open position" do
    board = Board.new
    board.create_maze("./data/shortest_maze.rb")
    board.set_open(" ")
    mouse1 = Mouse.new(board)
    mouse1.stub(:x_position){1}
    mouse1.stub(:y_position){1}
    mouse1.stub(:visited_path){[[0,1],[1,1]]}

    expect(mouse1.avoid_path.length).to eq(1)
  end

  it "should backtrack when there are no open positions" do
    board = Board.new
    board.create_maze("./data/deadend_maze.rb")
    board.set_open(" ")
    board.maze
    mouse1 = Mouse.new(board)
    mouse1.stub(:x_position){1}
    mouse1.stub(:y_position){1}
    mouse1.stub(:visited_path){[[0,1],[1,1]]}
    mouse1.backtrack

    expect(mouse1.visited_path[-2][0]).to eq(0)
  end


end

describe "#board_class" do

  it "should make mice" do
    board = Board.new
    board.make_mice(5)

    expect(board.mice.length).to eq(5)
  end

end











