function time_get_format_mm_ss_ms(_time_seconds = 0) {
  var _time_rounded = floor(_time_seconds),
      _minutes = _time_rounded div 60,
      _seconds = _time_rounded mod 60,
      _tenths = floor((_time_seconds - _time_rounded) * 10),
      _minutes_string = string_replace_all(string_format(_minutes, 2, 0), " ", "0"),
      _seconds_string = string_replace_all(string_format(_seconds, 2, 0), " ", "0");
  
  return $"{_minutes_string}:{_seconds_string}.{_tenths}";
};
