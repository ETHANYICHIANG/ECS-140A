package depth

import "hw2/expr"

//import "log"

// Depth returns the maximum number of AST nodes between the
// root of the tree and any leaf (literal or variable) in the tree.
func Depth(e expr.Expr) uint {
	// TODO: implement this function

	//log.Println(e)

	//log.Println(expr.Format(e))
	str := expr.Format(e)
	var count uint = 1

	for _, char := range str {
		if char == ')' {
			count++
		}
	}

	if str[len(str)-2] == ')' && str[len(str)-1] == ')' {
		return (count - 1)
	}

	return count

}
