# import nimprof
import std/[sugar, tables, strutils]
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
  for word in open(paramStr(1)).readAll().split():
    if word.isAmbi: word

echo ambigrams.len
echo ambigrams

# 0.33user 0.01system 0:00.34elapsed 100%CPU (0avgtext+0avgdata 30664maxresident)k
# 0inputs+0outputs (0major+7352minor)pagefaults 0swaps

# total executions of each stack trace:
# Entry: 1/15 Calls: 69/258 = 26.74% [sum: 69; 69/258 = 26.74%]
#   ambi_all.nim: ambi_all 257/258 = 99.61%
# Entry: 2/15 Calls: 58/258 = 22.48% [sum: 127; 127/258 = 49.22%]
#   system.nim: substr 130/258 = 50.39%
#   ambi_all.nim: ambi_all 257/258 = 99.61%
# Entry: 3/15 Calls: 34/258 = 13.18% [sum: 161; 161/258 = 62.40%]
#   comparisons.nim: <=% 36/258 = 13.95%
#   gc.nim: newObj 72/258 = 27.91%
#   system.nim: substr 130/258 = 50.39%
#   ambi_all.nim: ambi_all 257/258 = 99.61%
# Entry: 4/15 Calls: 31/258 = 12.02% [sum: 192; 192/258 = 74.42%]
#   ambi_all.nim: isAmbi 31/258 = 12.02%
#   ambi_all.nim: ambi_all 257/258 = 99.61%
# Entry: 5/15 Calls: 16/258 = 6.20% [sum: 208; 208/258 = 80.62%]
#   gc.nim: newObj 72/258 = 27.91%
#   system.nim: substr 130/258 = 50.39%
#   ambi_all.nim: ambi_all 257/258 = 99.61%
# Entry: 6/15 Calls: 11/258 = 4.26% [sum: 219; 219/258 = 84.88%]
#   comparisons.nim: <% 20/258 = 7.75%
#   gc.nim: newObj 72/258 = 27.91%
#   system.nim: substr 130/258 = 50.39%
#   ambi_all.nim: ambi_all 257/258 = 99.61%
# Entry: 7/15 Calls: 9/258 = 3.49% [sum: 228; 228/258 = 88.37%]
#   arithmetics.nim: -% 16/258 = 6.20%
#   gc.nim: decRef 18/258 = 6.98%
#   gc.nim: asgnRef 27/258 = 10.47%
#   ambi_all.nim: ambi_all 257/258 = 99.61%
# Entry: 8/15 Calls: 8/258 = 3.10% [sum: 236; 236/258 = 91.47%]
#   comparisons.nim: <% 20/258 = 7.75%
#   gc.nim: decRef 18/258 = 6.98%
#   gc.nim: asgnRef 27/258 = 10.47%
#   ambi_all.nim: ambi_all 257/258 = 99.61%
# Entry: 9/15 Calls: 7/258 = 2.71% [sum: 243; 243/258 = 94.19%]
#   arithmetics.nim: +% 11/258 = 4.26%
#   gc.nim: cellToUsr 7/258 = 2.71%
#   gc.nim: newObj 72/258 = 27.91%
#   system.nim: substr 130/258 = 50.39%
#   ambi_all.nim: ambi_all 257/258 = 99.61%
# Entry: 10/15 Calls: 7/258 = 2.71% [sum: 250; 250/258 = 96.90%]
#   arithmetics.nim: -% 16/258 = 6.20%
#   gc.nim: usrToCell 7/258 = 2.71%
#   gc.nim: asgnRef 27/258 = 10.47%
#   ambi_all.nim: ambi_all 257/258 = 99.61%
# Entry: 11/15 Calls: 3/258 = 1.16% [sum: 253; 253/258 = 98.06%]
#   arithmetics.nim: +% 11/258 = 4.26%
#   gc.nim: incRef 3/258 = 1.16%
#   gc.nim: asgnRef 27/258 = 10.47%
#   ambi_all.nim: ambi_all 257/258 = 99.61%
# Entry: 12/15 Calls: 2/258 = 0.78% [sum: 255; 255/258 = 98.84%]
#   comparisons.nim: <=% 36/258 = 13.95%
#   alloc.nim: interiorAllocatedPtr 2/258 = 0.78%
#   gc.nim: newObj 72/258 = 27.91%
#   system.nim: substr 130/258 = 50.39%
#   ambi_all.nim: ambi_all 257/258 = 99.61%
