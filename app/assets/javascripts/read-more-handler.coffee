$.fn.extend
  readmore_handler: ->
    $(this).find('.read-more').readmore
      delay: 100
      embedCSS: false
      heightMargin: 48
      moreLink: '<div class="read-more-toggle"><a href="#">
        <i class="pe-7s-angle-down pe-lg"></i>
        <i class="pe-7s-angle-down pe-lg"></i>
        <i class="pe-7s-angle-down pe-lg"></i>
        </a></div>'
      lessLink: '<div class="read-more-toggle"><a href="#">
        <i class="pe-7s-angle-up pe-lg"></i>
        <i class="pe-7s-angle-up pe-lg"></i>
        <i class="pe-7s-angle-up pe-lg"></i>
        </a></div>'

$(document).on 'shown.bs.modal', '.modal', ->
  $(this).readmore_handler()

$ ->
  $(document).readmore_handler()
