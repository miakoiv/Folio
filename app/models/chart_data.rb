class ChartData

  def self.by_age(records)
    by_age = records.count_by_age
    {
      labels: by_age.keys,
      datasets: [
        {
          data: by_age.values
        }
      ]
    }
  end

  def self.by_gender(records)
    by_gender = records.count_by_gender
    {
      labels: by_gender.keys,
      datasets: [
        {
          data: by_gender.values
        }
      ]
    }
  end
end
