$(document).on 'click', '.print', (e) ->
  if jsPrintSetup?
    p = jsPrintSetup
    p.setPaperSizeData 9 # A4
    p.setOption 'orientation', p.kPortraitOrientation
    p.setOption 'scaling', 100
    p.setOption 'shrinkToFit', 0
    p.setOption 'marginTop', 0
    p.setOption 'marginBottom', 0
    p.setOption 'marginLeft', 0
    p.setOption 'marginRight', 0
    p.setOption 'headerStrLeft', ''
    p.setOption 'headerStrCenter', ''
    p.setOption 'headerStrRight', ''
    p.setOption 'footerStrLeft', ''
    p.setOption 'footerStrCenter', ''
    p.setOption 'footerStrRight', ''
    p.setOption 'printBGColors', 1
    p.setOption 'printBGImages', 1
    p.print()
  else
    $('#print-modal').modal 'show'
