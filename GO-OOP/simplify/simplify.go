package simplify

import (
	"hw2/expr"
	//"log"
)

// Depth should return the simplified expresion
func Simplify(e expr.Expr, env expr.Env) expr.Expr {

	switch e.(type) {
	case expr.Literal:
		//log.Println("single literal")
		//log.Println(node)
		return e
	case expr.Var:
		node := e.(expr.Var)
		if _, exist := env[node]; exist {
			//log.Println("return var with env val")
			return expr.Literal(e.Eval(env))
		}
		return e
	case expr.Unary:
		//log.Println(X)
		node := e.(expr.Unary)
		node.X = Simplify(node.X, env)
		if _, ok := node.X.(expr.Literal); ok {
			return expr.Literal(node.Eval(env))
		} else {
			return node
		}
	case expr.Binary:
		node := e.(expr.Binary)

		//both literal
		if _, ok := node.X.(expr.Literal); ok {
			if _, ok := node.Y.(expr.Literal); ok {
				return expr.Literal(node.Eval(env))
			}
		}

		//simplify X and Y
		node.X = Simplify(node.X, env)
		node.Y = Simplify(node.Y, env)

		//x is still not
		if _, ok := node.X.(expr.Literal); !ok {

			//y is also not
			if _, ok := node.Y.(expr.Literal); !ok {
				return node
			}

			//y is literal
			if node.Y.Eval(env) == 0 {
				if node.Op == '*' {
					return expr.Literal(0)
				}
				if node.Op == '+' {
					return node.X
				}
			}

			if node.Y.Eval(env) == 1 {
				if node.Op == '*' {
					return node.X
				}
			}

			return node
		}

		// not
		if _, ok := node.Y.(expr.Literal); !ok {

			//y is also not
			if _, ok := node.X.(expr.Literal); !ok {
				return node
			}

			//y is literal
			if node.X.Eval(env) == 0 {
				if node.Op == '*' {
					return expr.Literal(0)
				}
				if node.Op == '+' {
					return node.Y
				}
			}

			if node.X.Eval(env) == 1 {
				if node.Op == '*' {
					return node.Y
				}
			}

			return node
		}

		return expr.Literal(node.Eval(env))
	}

	return e

	//panic("TODO: implement this!")
}
