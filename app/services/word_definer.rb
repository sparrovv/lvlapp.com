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
      related: related,
      translation: translation
    }
  end

  def definitions
    Wordnik.word.get_definitions(@word, :use_canonical => true, :source_dictionaries => "wiktionary").map do |d|
      d['text'] if d.is_a? Hash
    end.compact
  end

  def examples
    (Wordnik.word.get_examples(@word, :use_canonical => true, :source_dictionaries => "ahd")['examples'] || []).map do |d|
      d['text']
    end.compact
  end

  def related
    Wordnik.word.get_related(@word, :type => 'synonym', :use_canonical => true).map do |d|
     d['words'] if d.is_a? Hash
    end.compact.flatten
  end

  def translation
    Translator.new.translate(@word)
  end

  class Translator
    def initialize
      @translator = BingTranslator.new(Rails.configuration.azure_customer_id, Rails.configuration.azure_secret)
    end

    def translate(text, from='en', to='pl')
      @translator.translate text, from: from, to: to
    end
  end
end
