module ActivitiesHelper

  def resource_ident(activity)
    "#{resource_class(activity).model_name.human} ##{activity.resource_id}"
  end

  def resource_class(activity)
    if activity.resource.nil?
      activity.resource_type.constantize
    else
      activity.resource.class
    end
  end

  def resource_name(activity)
    activity.resource ||
      "#{t('.deleted')} #{resource_class(activity).model_name.human}"
  end
end
