module PeopleHelper

  # Generates options for languages people may have
  def language_options
    ISO_639::ISO_639_1.map { |l| [l[3], l[2]] }
  end

  def gender_options
    [
      [icon('venus'),      'f'],
      [icon('mars'),       'm'],
      [icon('genderless'), '']
    ]
  end

  def education_level_options
    EducationLevel.all.map { |e| [e.to_s, e.id] }
  end
end
