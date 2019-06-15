package nfa

//import "log"

// A state in the NFA is labeled by a single integer.
type state uint

// TransitionFunction tells us, given a current state and some symbol, which
// other states the NFA can move to.
//
// Deterministic automata have only one possible destination state,
// but we're working with non-deterministic automata.
type TransitionFunction func(st state, act rune) []state

func Reachable(
	// `transitions` tells us what our NFA looks like
	transitions TransitionFunction,
	// `start` and `final` tell us where to start, and where we want to end up
	start, final state,
	// `input` is a (possible empty) list of symbols to apply.
	input []rune,
) bool {
	// TODO Write the Reachable function,
	// return true if the nfa accepts the input,
	// return true if it doesn't reach to the final state with that input

	if len(input) == 0 {
		//log.Println("in base case")
		if start == final {
			//log.Println("true") 
			return true
		}
	} else {
		nextStates := transitions(start, input[0])
		//log.Println("next", nextStates)

		for _, state := range nextStates {
			//log.Println("in loop", state, final, input[1:len(input)])
			if Reachable(transitions, state, final, input[1:len(input)]) {
				return true
			}
		}
	}

	//log.Println("end of func")
	return false
}
