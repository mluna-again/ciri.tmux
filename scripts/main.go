package main

import (
	"flag"
	"fmt"
	"io"
	"log"
	"os"

	"golang.org/x/term"
)

var tty string

func main() {
	flag.StringVar(&tty, "tty", "", "tmux tty")
	flag.Parse()
	if tty == "" {
		log.Fatal("tty required")
	}

	b, err := io.ReadAll(os.Stdin)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Print(string(b))
	c, err := readchar()
	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("%s? ok\n", c)
}

func readchar() (string, error) {
	f, err := os.Open(tty)
	if err != nil {
		return "", err
	}

	oldState, err := term.MakeRaw(int(f.Fd()))
	if err != nil {
		return "", err
	}
	defer func() {
		err := term.Restore(int(f.Fd()), oldState)
		if err != nil {
			log.Println(err)
		}
	}()

	b := make([]byte, 1)
	_, err = f.Read(b)
	if err != nil {
		return "", nil
	}

	return string(b[0]), nil
}
