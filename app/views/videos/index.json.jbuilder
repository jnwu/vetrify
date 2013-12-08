json.array!(@videos) do |video|
  json.extract! video, :id, :profile_id, :pandastream_id, :url
  json.url video_url(video, format: :json)
end
