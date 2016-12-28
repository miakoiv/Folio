module ActivityTracker
  extend ActiveSupport::Concern

  # Tracks activity for given resource in the scope of current unit and
  # current user. Stores the action taken on given resource, storing any
  # changes made as differences, except changes between two blank values.
  def track(resource)
    differences = resource.previous_changes
      .except('created_at', 'updated_at')
      .reject { |attribute, value| value.reject(&:blank?).empty? }

    Activity.create(
      unit: current_unit,
      user: current_user,
      action: action_name,
      resource: resource,
      differences: differences
    )
  end
end
