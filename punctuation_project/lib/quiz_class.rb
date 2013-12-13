### QUIZ CLASS


class Quiz

attr_accessor :questions

  @@correct_answers = 0
  @@index = 0



  def initialize
  @questions = [{:name => "Electro", :type => "Villain"}, {:name =>"Octothorpe", :type => "Punctuation"}]
    # More punctuation, "Chevron", "Caret", "Solidus", "Guillements", "Interrobang", "Hedera", "Pilcrow"]
  end

  def tally
    @@correct_answers
  end

  def clear_answers
    @@correct_answers = 0
    @@used_villains = []
    @@used_punctuation = []
  end

  def index
    @@index
  end

  def index=
    @@index
  end

end