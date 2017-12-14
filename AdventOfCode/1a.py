def main():
  n = raw_input()
  ans = 0
  for i in xrange(len(n)-1):
    if n[i] == n[i+1]:
      ans += int(n[i])
  if n[0] == n[len(n)-1]:
    ans += int(n[0])
  print ans

if __name__ == "__main__":
  main()
