import sys

def main():
  ans = 0
  for line in sys.stdin:
    l = [int(x) for x in line.split()]
    l.sort(reverse=True)
    for i in xrange(len(l)-1):
      for j in l[i+1:]:
        if l[i] % j == 0:
          ans += (l[i] / j)
          break
  print ans

if __name__ == "__main__":
  main()
