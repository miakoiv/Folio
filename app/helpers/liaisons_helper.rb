module LiaisonsHelper

  def status_options
    Status.all.map { |s| [s.to_s, s.id, data: {label: s.appearance}] }
  end
end
