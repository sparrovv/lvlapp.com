require 'spec_helper'

describe ApplicationHelper do
  describe ".common_languages_list" do
    it "gets correct number of lang objects" do
      expect(helper.common_languages_list.uniq.size).to eq 15
    end

    it "gets correct format" do
      lang = helper.common_languages_list.select{|l| l.first == 'Polish' }.first
      expect(lang.first).to eq 'Polish'
      expect(lang.last).to eq 'pl'
    end

    it "returns 'Other' as the last element" do
      lang = helper.common_languages_list.last
      expect(lang.first).to eq 'Other'
      expect(lang.last).to eq 'other'
    end
  end
end
