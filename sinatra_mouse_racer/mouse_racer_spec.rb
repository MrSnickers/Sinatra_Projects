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
    board.set_open(" ", "#")
    mouse1 = Mouse.new(board)

    mouse1.set_left_start_point

    expect(mouse1.y_position).to eq(3)
  end

  it "should recognize [0,0] as only having two valid neighbors" do
    board = Board.new
    board.create_maze("./data/maze.rb")
    board.set_open(" ", "#")
    mouse1 = Mouse.new(board)
    mouse1.stub(:x_position){0}
    mouse1.stub(:y_position){0}

    expect(mouse1.valid_positions.length).to eq(2)
  end

  it "should recognize an open position in its neighbors" do
    board = Board.new
    board.create_maze("./data/maze.rb")
    board.set_open(" ", "#")
    mouse1 = Mouse.new(board)
    mouse1.stub(:x_position){1}
    mouse1.stub(:y_position){1}

    expect(mouse1.find_open_positions.length).to eq(2)
  end

  it "should move one space into an open position" do
    board = Board.new
    board.create_maze("./data/shortest_maze.rb")
    board.set_open(" ", "#")
    board.make_mice(1)
    board.mice[0].move_to_first_open_position

    expect(board.mice[0].x_position).to eq(1)
  end

  it "should recognize a visited square as not being an open position" do
    board = Board.new
    board.create_maze("./data/shortest_maze.rb")
    board.set_open(" ", "#")
    mouse1 = Mouse.new(board)
    mouse1.stub(:x_position){2}
    mouse1.stub(:y_position){1}
    mouse1.stub(:visited_squares){{[0,1]=>[1,1]}}

    expect(mouse1.fresh_squares.size).to eq(1)
  end

  it "should backtrack when there are no open positions" do
    board = Board.new
    board.create_maze("./data/deadend_maze.rb")
    board.set_open(" ", "#")
    board.make_mice(1)
    board.mice[0].stub(:x_position){3}
    board.mice[0].stub(:y_position){1}
    board.mice[0].stub(:visited_squares){{[0,1]=>[1,1], [1,1]=>[2,1], [1,1]=>[3,1]}}
    board.mice[0].backtrack

    expect(board.mice[0].inspect).to eq(0)

  end


end

describe "#board_class" do

  it "should make mice" do
    board = Board.new
    board.create_maze("./data/deadend_maze.rb")
    board.set_open(" ", "#")
    board.make_mice(5)

    expect(board.mice.length).to eq(5)
  end

end











