class WordDefiner

  def self.get(word)
    self.new(word).to_attrs
  end

  def initialize(word)
    @word = word
  end

  def to_attrs
    {
      definition: definitions,
      examples: examples,
      related: related
    }
  end

  def definitions
    Wordnik.word.get_definitions(@word, :use_canonical => true, :source_dictionaries => "wiktionary").map do |d|
      d['text']
    end
  end

  def examples
    (Wordnik.word.get_examples(@word, :use_canonical => true, :source_dictionaries => "ahd")['examples'] || []).map do |d|
      d['text']
    end
  end

  def related
    Wordnik.word.get_related(@word, :type => 'synonym', :use_canonical => true).map do |d|
      d['words']
    end.flatten
  end
end
