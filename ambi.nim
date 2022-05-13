import nimprof
import std/[sugar, tables]
import os

let ambiChars = {
  'p': 'd', 'd': 'p',
  'o':'o',
  's':'s',
  'x':'x',
  'l':'l',
  'w':'m', 'm':'w',
  'b':'q', 'q':'b',
  'n':'u', 'u':'n',
  # Doubtful
  # 't':'t',
  # 'i':'l', 'l':'i', 'i':'i',
  # 'a':'e', 'e':'a',
  # 'y':'h', 'h':'y',
}.toTable


proc isAmbi(word: string): bool =
  for i in 0..(word.len div 2):
    if word[i] notin ambiChars or word[word.len - i - 1] != ambiChars[word[i]]:
      return false
  return true

if paramCount() < 1:
  echo "Please supply a word file"
  quit(1)

let ambigrams = collect:
  for word in lines(paramStr(1)):
    if word.isAmbi: word

echo ambigrams.len
echo ambigrams

# 0.44user 0.01system 0:00.45elapsed 100%CPU (0avgtext+0avgdata 1808maxresident)k
# 0inputs+0outputs (0major+109minor)pagefaults 0swaps
#
#
# total executions of each stack trace:
# Entry: 1/17 Calls: 290/366 = 79.23% [sum: 290; 290/366 = 79.23%]
#   io.nim: readLine 307/366 = 83.88%
#   ambi.nim: ambi 365/366 = 99.73%
# Entry: 2/17 Calls: 14/366 = 3.83% [sum: 304; 304/366 = 83.06%]
#   comparisons.nim: <% 18/366 = 4.92%
#   gc.nim: newObjRC1 34/366 = 9.29%
#   ambi.nim: ambi 365/366 = 99.73%
# Entry: 3/17 Calls: 13/366 = 3.55% [sum: 317; 317/366 = 86.61%]
#   comparisons.nim: <=% 16/366 = 4.37%
#   gc_common.nim: isOnStack 13/366 = 3.55%
#   gc.nim: unsureAsgnRef 13/366 = 3.55%
#   io.nim: readLine 307/366 = 83.88%
#   ambi.nim: ambi 365/366 = 99.73%
# Entry: 4/17 Calls: 10/366 = 2.73% [sum: 327; 327/366 = 89.34%]
#   ambi.nim: ambi 365/366 = 99.73%
# Entry: 5/17 Calls: 9/366 = 2.46% [sum: 336; 336/366 = 91.80%]
#   gc.nim: newObjRC1 34/366 = 9.29%
#   ambi.nim: ambi 365/366 = 99.73%
# Entry: 6/17 Calls: 5/366 = 1.37% [sum: 341; 341/366 = 93.17%]
#   arithmetics.nim: -% 7/366 = 1.91%
#   gc.nim: usrToCell 5/366 = 1.37%
#   gc.nim: nimGCunrefNoCycle 10/366 = 2.73%
#   ambi.nim: ambi 365/366 = 99.73%
# Entry: 7/17 Calls: 4/366 = 1.09% [sum: 345; 345/366 = 94.26%]
#   ambi.nim: isAmbi 4/366 = 1.09%
#   ambi.nim: ambi 365/366 = 99.73%
# Entry: 8/17 Calls: 4/366 = 1.09% [sum: 349; 349/366 = 95.36%]
#   system.nim: == 4/366 = 1.09%
#   io.nim: readLine 307/366 = 83.88%
#   ambi.nim: ambi 365/366 = 99.73%
# Entry: 9/17 Calls: 4/366 = 1.09% [sum: 353; 353/366 = 96.45%]
#   comparisons.nim: <% 18/366 = 4.92%
#   gc.nim: decRef 5/366 = 1.37%
#   gc.nim: nimGCunrefNoCycle 10/366 = 2.73%
#   ambi.nim: ambi 365/366 = 99.73%
# Entry: 10/17 Calls: 3/366 = 0.82% [sum: 356; 356/366 = 97.27%]
#   arithmetics.nim: +% 7/366 = 1.91%
#   gc.nim: newObjRC1 34/366 = 9.29%
#   ambi.nim: ambi 365/366 = 99.73%
# Entry: 11/17 Calls: 3/366 = 0.82% [sum: 359; 359/366 = 98.09%]
#   arithmetics.nim: +% 7/366 = 1.91%
#   gc.nim: cellToUsr 3/366 = 0.82%
#   gc.nim: newObjRC1 34/366 = 9.29%
#   ambi.nim: ambi 365/366 = 99.73%
# Entry: 12/17 Calls: 2/366 = 0.55% [sum: 361; 361/366 = 98.63%]
#   comparisons.nim: <=% 16/366 = 4.37%
#   alloc.nim: interiorAllocatedPtr 3/366 = 0.82%
#   gc.nim: newObjRC1 34/366 = 9.29%
#   ambi.nim: ambi 365/366 = 99.73%
