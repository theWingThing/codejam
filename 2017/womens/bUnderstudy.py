def main():
  for t in xrange(int(raw_input())):
    N = int(raw_input())
    P = [float(x) for x in raw_input().split()]
    P.sort()
    probs = 1
    for i in xrange(N):
      probs *= 1 - (P.pop(0)*P.pop())
    print "Case #{}: {}".format(t+1, probs)

if __name__ == "__main__":
  main()
