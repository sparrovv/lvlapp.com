class PhraseWorker

  def self.enrich(phrase)
    fields_map = WordDefiner.get(phrase.name)

    fields_map.each do |k, v|
      phrase.send("#{k}=", v)
    end

    phrase.save!
  end

end
