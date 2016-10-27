class PersonStats

  def initialize(params = {})
    @params = params
  end

  def count
    Person.count
  end

  def latest
    Person.reorder(created_at: :desc).first
  end
end
