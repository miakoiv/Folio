Array.class_eval do
  def accumulate(base = 0)
    self.map { |n| base += n }
  end
end
