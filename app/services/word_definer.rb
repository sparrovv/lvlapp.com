class WordDefiner

  def self.get(word, native_language)
    self.new(word, native_language).to_attrs
  end

  def initialize(word, native_language)
    @word = word
    @native_language = native_language
  end

  def canonical_name
    @canonical_name ||= begin
                          if some_def = definition.first and some_def['word'].present?
                            some_def['word']
                          else
                            @word
                          end
                        end
  end

  def to_attrs
    {
      name: canonical_name,
      definition: definitions,
      examples: examples,
      related: related,
    }.tap do |hash|
      hash[:translation] = load_translation? ? translation : ''
    end
  end


  def definitions
    definition.map do |d|
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
    phrase_lang = 'en'
    Translator.new.translate(canonical_name, phrase_lang, @native_language)
  end

  class Translator
    def initialize
      @translator = BingTranslator.new(Rails.configuration.azure_customer_id, Rails.configuration.azure_secret)
    end

    def translate(text, from='en', to='pl')
      @translator.translate text, from: from, to: to
    end
  end

  def definition
    @definition ||= Wordnik.word.get_definitions(@word, :use_canonical => true, :source_dictionaries => "wiktionary")
  end

  def load_translation?
    @native_language != User::OTHER_NATIVE_LANG
  end
end
