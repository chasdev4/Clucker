String countFormat(int value) {
  String string = '';
  if (value > 1000000000) {
    string = '${(value / 1000000000).toStringAsFixed(1)}T';
  } else if (value > 1000000) {
    string = '${(value / 1000000).toStringAsFixed(1)}M';
  } else if (value > 1000) {
    string = '${(value / 1000).toStringAsFixed(1)}K';
  } else {
    string = '$value';
  }
  return string;
}