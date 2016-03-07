json.array!(@user_voices) do |user_voice|
  json.extract! user_voice, :id, :name, :email, :string, :description
  json.url user_voice_url(user_voice, format: :json)
end
