module PeopleHelper

  # Generates options for languages people may have
  def language_options
    [['suomi', :fi], ['svenska', :sv], ['English', :en]]
  end

  def gender_options
    [
      [icon('venus'),      'f'],
      [icon('mars'),       'm'],
      [icon('genderless'), '']
    ]
  end
end
