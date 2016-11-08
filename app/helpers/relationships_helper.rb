module RelationshipsHelper

  def relation_options
    Relation.all.map { |r| [r.to_s, r.id] }
  end
end
