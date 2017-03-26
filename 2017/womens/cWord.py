def numIOs(grid):
  for y in len(grid):
    for x in len(grid[y]):
      pass

def oneRow(n):
  prev = 'I'
  ans = "I"
  for i in xrange(n):
    if prev == 'I':
      ans += "/O"
      prev = 'O'
    else:
      ans += "/I"
      prev = 'I'
  return ans

def numCount(N):
#  if N >= 35:
#    return (oneRow(7) + '\n')*2 + oneRow(7)
  if N < 15:
    return [oneRow(7),oneRow(N-7)]
  if N <=7:
    return [oneRow(N)]
  return [oneRow(7),oneRow(7)] + (((N-14) / 21) *[oneRow(7)])
  if N > 14 and N <= 245: #?
    ans = ""
    while N > 14:
      ans += oneRow(7) + '\n'
      N -= 21
    ans += numCount(N)
    return ans
  if N < 15:
    return oneRow(7) + '\n' + oneRow(N-7)
  if N <=7:
    return oneRow(N)


def main():
  for t in xrange(int(raw_input())):
    (_, N) = (int(x) for x in raw_input().split())
    ans = numCount(N)
    print "Case #{}:\n{}".format(t+1, ans)

if __name__ == "__main__":
  main()
