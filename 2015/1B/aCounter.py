import math

x = {}

def digits(n):
  return int(math.log10(n)) + 1



def main():
  for t in xrange(int(raw_input())):
    N = int(raw_input())

    if N <= 20:
      ans = N

    ans = f(N, 1, 1, False)
    print "Case #{}: {}".format(t+1, ans)

if __name__ == "__main__":
  main()
