if instance_exists(_mouse) {
  instance_destroy(_mouse);  
}

if is_method(on_clean_up) {
  on_clean_up();  
}
