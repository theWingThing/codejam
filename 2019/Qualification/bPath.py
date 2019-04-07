def main():
  for t in xrange(int(raw_input())):
    n = int(raw_input())
    lyd = raw_input()
    path = ""
    for d in lyd:
      if d == 'E':
        path += 'S'
      else:
        path += 'E'
    print "Case #{}: {}".format(t+1, path)

if __name__ == "__main__":
  main()