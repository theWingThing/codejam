def round(i, opponents):
  moves = set()
  for o in opponents:
    moves.add(o[i % len(o)])
  return moves

def canWin(moves):
  if len(moves) == 3:
    return False
  elif len(moves) == 2:
    if 'P' not in moves:
      return 'R'
    elif 'R' not in moves:
      return 'S'
    else:
      return 'P'
  else:
    if 'P' in moves:
      return 'S'
    elif 'R' in moves:
      return 'P'
    else:
      return 'R'

def remove(i, move, opponents):
  newOpponents = []
  for o in opponents:
    if o[i % len(o)] != trump(move):
      newOpponents.append(o)
  return newOpponents

def trump(move):
  if move == 'P':
    return 'R'
  elif move == 'S':
    return 'P'
  else:
    return 'S'

def main():
  for t in xrange(int(raw_input())):
    opponents = [] #list of moves for each opponent
    N = int(raw_input())
    ans = ""
    imp = False
    for n in xrange(N):
      opponents.append(list(raw_input()))
    i = 0
    m = max([len(o) for o in opponents])
    while not imp and i < 501 and len(opponents) > 0: 
      moves = round(i, opponents)
      a = canWin(moves)
      if not a:
        print "Case #{}: {}".format(t+1, "IMPOSSIBLE")
        imp = True
        break
      elif len(moves) == 1:
        ans += a
        print "Case #{}: {}".format(t+1, ans)
        imp = True
        break
      ans += a
      opponents = remove(i, a, opponents)
      i += 1
    if not i < 501:
      print "Case #{}: {}".format(t+1, "IMPOSSIBLE")
    elif not imp or len(opponents) == 0:
      print "Case #{}: {}".format(t+1, ans)

if __name__ == "__main__":
  main()
