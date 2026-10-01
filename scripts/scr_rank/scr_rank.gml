function rank_get_score_string(player_score) {
  if instance_exists(oBird) {
    return "0.5099";
  } else {
    player_score = min(player_score, 99);
    
    var score_string = string_replace_all(string_format(player_score, 3, 0), " ", "0");

    return $"1.0{score_string}";
  }
}