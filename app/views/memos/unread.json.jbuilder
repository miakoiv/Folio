json.array! @memos do |memo|
  json.id memo.id
  json.title memo.title
  json.icon memo.icon
  json.url memo_path(memo)
end
