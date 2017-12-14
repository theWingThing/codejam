import sys

def main():
  ans = 0
  for line in sys.stdin:
    l = [int(x) for x in line.split()]
    sm = lg = l[0]
    for n in l:
      if n < sm:
        sm = n
      elif n > lg:
        lg = n
    ans += (lg - sm)
  print ans

if __name__ == "__main__":
  main()
