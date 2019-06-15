package nfa

import (
	"sync"
)

// A nondeterministic Finite Automaton (NFA) consists of states,
// symbols in an alphabet, and a transition function.

// A state in the NFA is represented as an unsigned integer.
type state uint

// Given the current state and a symbol, the transition function
// of an NFA returns the set of next states the NFA can transition to
// on reading the given symbol.
// This set of next states could be empty.
type TransitionFunction func(st state, act rune) []state

// Reachable returns true if there exists a sequence of transitions
// from `transitions` such that if the NFA starts at the start state
// `start` it would reach the final state `final` after reading the
// entire sequence of symbols `input`; Reachable returns false otherwise.
func Reachable(
	// `transitions` tells us what our NFA looks like
	transitions TransitionFunction,
	// `start` and `final` tell us where to start, and where we want to end up
	start, final state,
	// `input` is a (possible empty) list of symbols to apply.
	input []rune,
) bool {
	var wg sync.WaitGroup

	result := make(chan bool, 100000)

	wg.Add(1)

	doReachable(transitions, start, final, input, &wg, result)

	wg.Wait()
	close(result)

	for r := range result {
		if r {
			return true
		}
	}
	return false
}

func doReachable(transitions TransitionFunction, start, final state, input []rune, wg *sync.WaitGroup, result chan bool) {

	if len(input) == 0 {
		//log.Println("in base case")
		if start == final {
			//log.Println("true")
			result <- true
		}
	} else {
		nextStates := transitions(start, input[0])
		//log.Println("next", nextStates)

		for _, state := range nextStates {
			//log.Println("in loop", state, final, input[1:len(input)])
			wg.Add(1)
			go doReachable(transitions, state, final, input[1:len(input)], wg, result)
		}
	}

	result <- false
	wg.Done()
}
