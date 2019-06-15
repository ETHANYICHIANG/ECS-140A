package bug1

import (
	"sync"
)

// Counter stores a count.
//type Counter struct {
//	n int64
//}

// "safe" version of counter for concurrency
type Counter struct {
	n   int64
	mux sync.Mutex
}

// Inc increments the count in the Counter.
func (c *Counter) Inc() {
	c.mux.Lock()
	// Lock so only one goroutine at a time can access the map c.v.
	c.n++
	c.mux.Unlock()
}


