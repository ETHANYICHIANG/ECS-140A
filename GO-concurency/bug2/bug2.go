package bug2

import (
	"sync"
)

func bug2(n int, foo func(int) int, out chan int) {
	var wg sync.WaitGroup
	ch := make(chan int, n)

	for i := 0; i < n; i++ {
		
		ch <- i
		wg.Add(1)

		go func() {
			temp := <-ch
			out <- foo(temp)
			wg.Done()
		}()

	}
	wg.Wait()
	close(out)
}
