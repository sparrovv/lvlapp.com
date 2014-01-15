require 'google/api_client'
require 'json'

class YoutubeVideo
  class << self
    def get(id)
      retrieve_results(raw_data(id))
    end

    def raw_data(id)
      client = Google::APIClient.new
      youtube = client.discovered_api('youtube', 'v3')
      client.authorization = nil

      result = client.execute(
        key: Rails.configuration.google_api_key,
        api_method: youtube.videos.list,
        parameters: {id: id, part: 'contentDetails'}
      )

      result = JSON.parse(result.data.to_json)
    end

    def retrieve_results(resp)
      return false if resp['items'].empty?
      raise 'More than one response' if resp['items'].size > 1

      video_info = resp['items'][0]

      # "PT21S" "PT5M21S" "PT2H10M22S"
      matched_duration = video_info['contentDetails']['duration'].scan(/(\d+)/).flatten

      duration = if matched_duration.size == 1
                   matched_duration.first.to_i
                 elsif matched_duration.size == 2
                   matched_duration.first.to_i * 60 + matched_duration.last.to_i
                 elsif matched_duration.size == 3
                   matched_duration[0].to_i * 60 * 60 + matched_duration[1].to_i * 60 + matched_duration.last.to_i
                 else
                   raise "something is wrong in duration #{matched_duration}"
                 end

      blocked = if restriction = video_info['contentDetails']['regionRestriction']
                  restriction['blocked']
                else
                  []
                end
      {
        duration: duration,
        blocked: blocked,
      }
    end
  end
end
