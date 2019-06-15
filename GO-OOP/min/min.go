package min

import "sort"

// Min returns the minimum value in the arr,
// and 0 if arr is nil.
func Min(arr []int) int {
	// TODO: implement this function.

	if len(arr) == 0 {
		return 0
	} else {
		sort.Ints(arr)
		return arr[0]
	}

}
