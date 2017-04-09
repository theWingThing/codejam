from heapq import *

def main():
  for t in xrange(int(raw_input())):
    (N, K) = (int(x) for x in raw_input().split())
    q = []
    heappush(q, N*-1)

    for k in xrange(K-1):
      x = heappop(q)
      l = r = (((x*-1)/2)*-1)
      if x % 2 == 0:
        l += 1
      if r < 0:
        heappush(q, r)
      if l < 0:
        heappush(q, l)

    x = heappop(q)
    l = r = (((x*-1)/2)*-1)
    if x % 2 == 0:
      l += 1

    print "Case #{}: {}".format(t+1, str(r*-1) + " " + str(l*-1))

if __name__ == "__main__":
  main()
