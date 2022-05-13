# import nimprof
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
  if word[0] notin ambiChars: return false

  result = true
  for i in 0..(word.len div 2):
    if word[i] notin ambiChars or word[word.len - i - 1] != ambiChars[word[i]]:
      result = false

if paramCount() < 1:
  echo "Please supply a word file"
  quit(1)

let ambigrams = collect:
  for word in lines(paramStr(1)):
    if word.isAmbi: word

echo ambigrams.len
echo ambigrams

#0.55user 0.00system 0:00.56elapsed 99%CPU (0avgtext+0avgdata 1744maxresident)k
#0inputs+0outputs (0major+107minor)pagefaults 0swaps
#
#
# total executions of each stack trace:
# Entry: 1/13 Calls: 333/441 = 75.51% [sum: 333; 333/441 = 75.51%]
#   io.nim: readLine 354/441 = 80.27%
#   ambi.nim: ambi 440/441 = 99.77%
# Entry: 2/13 Calls: 20/441 = 4.54% [sum: 353; 353/441 = 80.05%]
#   comparisons.nim: <% 26/441 = 5.90%
#   gc.nim: newObjRC1 46/441 = 10.43%
#   ambi.nim: ambi 440/441 = 99.77%
# Entry: 3/13 Calls: 19/441 = 4.31% [sum: 372; 372/441 = 84.35%]
#   ambi.nim: isAmbi 19/441 = 4.31%
#   ambi.nim: ambi 440/441 = 99.77%
# Entry: 4/13 Calls: 18/441 = 4.08% [sum: 390; 390/441 = 88.44%]
#   comparisons.nim: <=% 24/441 = 5.44%
#   gc_common.nim: isOnStack 18/441 = 4.08%
#   gc.nim: unsureAsgnRef 18/441 = 4.08%
#   io.nim: readLine 354/441 = 80.27%
#   ambi.nim: ambi 440/441 = 99.77%
# Entry: 5/13 Calls: 11/441 = 2.49% [sum: 401; 401/441 = 90.93%]
#   gc.nim: newObjRC1 46/441 = 10.43%
#   ambi.nim: ambi 440/441 = 99.77%
# Entry: 6/13 Calls: 8/441 = 1.81% [sum: 409; 409/441 = 92.74%]
#   ambi.nim: ambi 440/441 = 99.77%
# Entry: 7/13 Calls: 8/441 = 1.81% [sum: 417; 417/441 = 94.56%]
#   arithmetics.nim: +% 8/441 = 1.81%
#   gc.nim: cellToUsr 8/441 = 1.81%
#   gc.nim: newObjRC1 46/441 = 10.43%
#   ambi.nim: ambi 440/441 = 99.77%
# Entry: 8/13 Calls: 7/441 = 1.59% [sum: 424; 424/441 = 96.15%]
#   arithmetics.nim: -% 8/441 = 1.81%
#   gc.nim: decRef 13/441 = 2.95%
#   gc.nim: nimGCunrefNoCycle 13/441 = 2.95%
#   ambi.nim: ambi 440/441 = 99.77%
# Entry: 9/13 Calls: 6/441 = 1.36% [sum: 430; 430/441 = 97.51%]
#   comparisons.nim: <=% 24/441 = 5.44%
#   alloc.nim: interiorAllocatedPtr 7/441 = 1.59%
#   gc.nim: newObjRC1 46/441 = 10.43%
#   ambi.nim: ambi 440/441 = 99.77%
# Entry: 10/13 Calls: 6/441 = 1.36% [sum: 436; 436/441 = 98.87%]
#   comparisons.nim: <% 26/441 = 5.90%
#   gc.nim: decRef 13/441 = 2.95%
#   gc.nim: nimGCunrefNoCycle 13/441 = 2.95%
#   ambi.nim: ambi 440/441 = 99.77%
# Entry: 11/13 Calls: 3/441 = 0.68% [sum: 439; 439/441 = 99.55%]
#   system.nim: == 3/441 = 0.68%
#   io.nim: readLine 354/441 = 80.27%
#   ambi.nim: ambi 440/441 = 99.77%
