$ ->
  $('.infinite-scroll').infinitePages
    loading: ->
      $('.infinite-pagination').addClass 'active'
    error: ->
      $('.infinite-pagination > a').addClass 'progress-bar-danger'
