def calc(p):
  dmg = 0
  chg = 1
  for cmd in p:
    if cmd == 'C':
      chg *= 2
    else:
      dmg += chg
  return dmg

def move(p):
  for i in xrange(len(p)-1, 0, -1):#p[::-1]
    if p[i] == 'S' and p[i-1] == 'C':
      p[i] = 'C'
      p[i-1] = 'S'
      return False
  return True

def main():
  for t in xrange(int(raw_input())):
    d, p = raw_input().split()
    d = int(d)
    p = list(p)
    
    same = False
    count = 0
    while True:
      if same:
        print "Case #{}: {}".format(t+1, 'IMPOSSIBLE')
        break
      elif calc(p) <= d:
        print "Case #{}: {}".format(t+1, count)
        break
      else:
        same = move(p)
        count += 1

if __name__ == "__main__":
  main()
