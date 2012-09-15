require 'world'

describe World do

  it 'should map living neighbours one row' do
    subject.set ['ooo']
    subject.living.should == ['121']
  end

  it 'should map living neighbours one row no live neighbours' do
    subject.set ['xox']
    subject.living.should == ['101']
  end

  it 'should map living neighbours two rows' do
    subject.set ['xox', 
                 'oox']
    subject.living.should == ['211','121']
  end

  it 'should map living neighbours three rows' do
    subject.set ['xox', 
                 'oox',
                 'xxx']
    subject.living.should == ['211','121','110']
  end

  it 'should map living neighbours three rows more alive in last row' do
    subject.set ['xox', 
                 'oox',
                 'xox']
    subject.living.should == ['211','131','211']
  end

  # Any live cell with two or three live neighbours lives on to the next generation.
  # Any live cell with fewer than two live neighbours dies, as if caused by under-population.
  it 'should know next tick' do
    subject.set ['xox', 
                 'oox',
                 'xox']
    subject.tick.should ==  ['xxx', 
                             'xox',
                             'xxx']
  end

  # Any live cell with more than three live neighbours dies, as if by overcrowding.
  it 'should know die overpopulation' do
    subject.set ['xox', 
                 'ooo',
                 'xox']
    subject.tick.should ==  ['xxx', 
                             'xxx',
                             'xxx']
  end

  # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  it 'should reproduce exactly three' do
    subject.set ['xox', 
                 'oxx',
                 'xox']
    subject.tick.should ==  ['xxx', 
                             'xox',
                             'xxx']
  end

end
 

