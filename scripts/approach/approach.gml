/// @description approach(current, target, amount)
/// @param current
/// @param  target
/// @param  amount
function approach(current, target, amount) {
	if (current < target) {
	    current = min(current + amount, target); 
	} else {
	    current = max(current - amount, target);
	}
	return current;
}
