class ChartData

  def initialize(records, method)
    @data = records.send(method)
  end

  def size
    @data.size
  end

  def labels
    @data.keys
  end

  def data
    @data.values
  end
end
