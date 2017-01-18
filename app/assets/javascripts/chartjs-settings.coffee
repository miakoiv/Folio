Chart.defaults.global.defaultFontFamily = "'Open Sans', sans-serif"
Chart.defaults.global.legend.display = false

Chart.defaults.colors =
  qualitative:
    backgroundColor: Palette.generate 'qualitative', 0.5
    hoverBackgroundColor: Palette.generate 'qualitative', 0.8
  sequential:
    backgroundColor: Palette.generate 'sequential', 0.5
    hoverBackgroundColor: Palette.generate 'sequential', 0.8
