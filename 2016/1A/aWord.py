def main():
  for t in xrange(int(raw_input())):
    letters = list(raw_input())
    letters.reverse()
    word = letters.pop()
    while len(letters) > 0:
      c = letters.pop()
      if c < word[0]:
        word += c
      else:
        word = c + word
    print "Case #{}: {}".format(t+1, word)

if __name__ == "__main__":
  main()
