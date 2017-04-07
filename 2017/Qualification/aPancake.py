def flip(c):
  if c == '+':
    return '-'
  else:
    return '+'

def main():
  for t in xrange(int(raw_input())):
    s, k = raw_input().split()
    s = list(s)
    k = int(k)
    count = 0

    for i in xrange(len(s)-k+1):
      if s[i] == '-':
        for j in xrange(k):
          s[i+j] = flip(s[i+j])
        count += 1

    for l in s:
      if l != '+':
        count = "IMPOSSIBLE"
        break
    print "Case #{}: {}".format(t+1, count)

if __name__ == '__main__':
  main()
