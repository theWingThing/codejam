x = {}

def f(N, num, flipped):
  if N == num:
    return 1
  elif num in x:
    return x[num]
  if num != int(str(num)[::-1]) and not flipped:
    x[num] = min(f(N, num+1, False), f(N, int(str(num)[::-1]), True)) + 1
  else:
    x[num] = f(N, num+1, False) + 1
  return x[num]

def main():
  for t in xrange(int(raw_input())):
    N = int(raw_input())
    ans = f(N, 1, False)
    print "Case #{}: {}".format(t+1, ans)

if __name__ == "__main__":
  main()
