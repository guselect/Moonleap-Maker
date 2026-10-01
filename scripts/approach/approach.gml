/// @description The function that approaches the `current` value to the `target` value by given `amount`. 
/// @param {real} current The value that will approach the `target` value.
/// @param {real} target The value for the current value to approach.
/// @param {real} amount The amount to be incremented or decremented to the `current` value to approach the `target` value.
function approach(current, target, amount) {
	if (current < target) {
	    current = min(current + amount, target); 
	} else {
	    current = max(current - amount, target);
	}
	return current;
}
