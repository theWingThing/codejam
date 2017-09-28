def main():
  for t in xrange(int(raw_input())):
    n = int(raw_input())
    a = [int(x) for x in raw_input().split()]
    b = [int(x) for x in raw_input().split()]
    a.sort()
    b.sort(reverse=True)

    ans = 0
    for i in xrange(n):
      ans += a[i] * b[i]
    print "Case #{}: {}".format(t+1, ans)

if __name__ == "__main__":
  main()
