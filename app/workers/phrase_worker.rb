class PhraseWorker

  def self.enrich(phrase, native_language)
    fields_map = WordDefiner.get(phrase.name, native_language)

    fields_map.each do |k, v|
      phrase.send("#{k}=", v)
    end

    phrase.save!
  end

end
