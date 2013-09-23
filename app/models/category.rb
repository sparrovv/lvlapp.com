class Category

  attr_reader :id, :name

  LIST = {
    1 => 'Rock',
    2 => 'Ted',
    3 => 'Pop',
    4 => 'Hard Rock',
    5 => 'TV Show',
    6 => 'Movie Scene',
    7 => 'Documentary',
    8 => 'Metal',
    9 => 'Other',
  }

  def self.all
    LIST.each do |id, name|
      Category.new(id, name)
    end
  end

  def self.get(id)
    Category.new(id, LIST[id])
  end

  def initialize(id, name)
    @id = id
    @name = name
  end

end
