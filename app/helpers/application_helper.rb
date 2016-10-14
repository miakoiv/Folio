module ApplicationHelper

  # Include this helper in the layout to control Turbolinks caching behavior.
  # See app/controllers/concerns/turbolinks_cache_control.rb
  def turbolinks_cache_control_meta_tag
    tag :meta, name: 'turbolinks-cache-control',
      content: @turbolinks_cache_control || 'cache'
  end
end
