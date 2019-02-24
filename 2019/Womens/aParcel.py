def main():
  for t in range(int(raw_input())):
    k = int(raw_input())
    elevations = [int(x) for x in raw_input().split()]
    ele = [elevations[0]]
    for x in elevations[1:]:
      if x != ele[-1]:
        ele.append(x)

    count = 0
    direc = ""
    new = True
    for i in range(1, len(ele)):
      if direc != direction(ele[i-1], ele[i]):
        if not new:
          count += 1
          new = True
        else:
          new = False
        direc = direction(ele[i-1], ele[i])
      #print "count: {}, new: {}, direc: {}, [{}, {}]".format(count, new, direc, ele[i-1], ele[i])

    if new and count > 0:
      count -= 1
    print "Case #{}: {}".format(t+1, count)

def direction(a, b):
  if a < b:
    return "up"
  else:
    return "down"

if __name__ == "__main__":
  main()
