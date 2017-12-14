def main():
  n = raw_input()
  m = n[len(n)/2:] + n[:len(n)/2]
  ans = 0
  for i in xrange(len(n)):
    if n[i] == m[i]:
      ans += int(n[i])
  print ans

if __name__ == "__main__":
  main()
