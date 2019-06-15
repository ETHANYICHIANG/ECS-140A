package smash

import (
	"bufio"
	//"fmt"
	"io"
	"strings"
	"sync"
	"bytes"
)

type word string

func Smash(r io.Reader, smasher func(word) uint32) map[uint32]uint {
	m := make(map[uint32]uint)

	var wg sync.WaitGroup
	var mu sync.Mutex

	buf := new(bytes.Buffer)
	buf.ReadFrom(r)
	s := buf.String() // Does a complete copy of the bytes in the buffer.


	// parese input scanner := bufio.NewScanner(strings.NewReader(input))
	//input := "foo   bar   \n   baz"
	//fmt.Println(r)
	scanner := bufio.NewScanner(strings.NewReader(s))
	//fmt.Println(s)
	scanner.Split(bufio.ScanWords)
	for scanner.Scan() {
		//var w word
		//fmt.Println(scanner.Text())
		keyVal := smasher(word(scanner.Text()))
		//fmt.Println(keyVal)
		wg.Add(1)
		go doSmash(keyVal, &wg, m, &mu)
	}

	wg.Wait()
	//fmt.Println(m)
	return m
}

func doSmash(keyVal uint32, wg *sync.WaitGroup, M map[uint32]uint, mu *sync.Mutex) {
	//fmt.Println("in doSmash with: ", keyVal) 
	mu.Lock()
	M[keyVal]++
	mu.Unlock()

	wg.Done()
}
