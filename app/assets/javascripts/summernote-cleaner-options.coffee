cleaner_options =
  notTime: 0
  action: 'paste'
  newline: '<p><br></p>'
  notStyle: 'position: absolute; top: 0; left: 0; right: 0;'
  keepHtml: false
  keepClasses: false
  badTags: ['style', 'script', 'applet', 'embed', 'noframes', 'noscript', 'html']
  badAttributes: ['style', 'start']

(exports ? this).cleaner_options = cleaner_options
