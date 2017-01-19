Chart.defaults.global.defaultFontFamily = "'Open Sans', sans-serif"
Chart.defaults.global.legend.display = false
Chart.defaults.global.elements.line.borderColor = Palette.pick 'qualitative', 1, 0.5
Chart.defaults.global.elements.rectangle.backgroundColor = Palette.pick 'qualitative', 0, 0.5

Chart.defaults.colors =
  qualitative:
    backgroundColor: Palette.generate 'qualitative', 0.5
  sequential:
    backgroundColor: Palette.generate 'sequential', 0.5
