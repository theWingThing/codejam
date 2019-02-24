def main():
  for t in range(int(raw_input())):
    k = int(raw_input())
    elevations = [int(x) for x in raw_input().split()]
    (a, b) = hasDesire(elevations)
    count = 0
    while len(a) > 0:
      (a, b) = hasDesire(b)
      count += 1
    count -= 1
    print "Case #{}: {}".format(t+1, count)

def hasDesire(lands):
  new = True
  direc = ""
  for i in range(1, len(lands)):
    d = direction(lands[i-1], lands[i])
    if direc != d and d != "same":
      if new:
        new = False
      else:
        return (lands[:i], lands[i:])
      direc = d
  return ([], lands)

def direction(a, b):
  if a < b:
    return "up"
  elif a > b:
    return "down"
  else:
    return "same"

if __name__ == "__main__":
  main()
