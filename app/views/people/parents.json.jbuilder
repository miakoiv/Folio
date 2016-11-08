json.results @people do |person|
  json.extract! person, :id, :text
end
