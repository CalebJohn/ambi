import nimprof
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
  for i in 0..(word.len div 2):
    if word[i] notin ambiChars or word[word.len - i - 1] != ambiChars[word[i]]:
      return false
  return true


if paramCount() < 1:
  echo "Please supply a word file"
  quit(1)

let ambigrams = collect:
  for word in open(paramStr(1)).readAll().split():
    if word.isAmbi: word

echo ambigrams.len
echo ambigrams

# 0.21user 0.01system 0:00.22elapsed 100%CPU (0avgtext+0avgdata 30672maxresident)k
# 0inputs+0outputs (0major+7350minor)pagefaults 0swaps


#total executions of each stack trace:
#Entry: 1/15 Calls: 60/190 = 31.58% [sum: 60; 60/190 = 31.58%]
#  ambi_all.nim: ambi_all 189/190 = 99.47%
#Entry: 2/15 Calls: 46/190 = 24.21% [sum: 106; 106/190 = 55.79%]
#  system.nim: substr 99/190 = 52.11%
#  ambi_all.nim: ambi_all 189/190 = 99.47%
#Entry: 3/15 Calls: 27/190 = 14.21% [sum: 133; 133/190 = 70.00%]
#  comparisons.nim: <=% 28/190 = 14.74%
#  gc.nim: newObj 53/190 = 27.89%
#  system.nim: substr 99/190 = 52.11%
#  ambi_all.nim: ambi_all 189/190 = 99.47%
#Entry: 4/15 Calls: 10/190 = 5.26% [sum: 143; 143/190 = 75.26%]
#  arithmetics.nim: -% 15/190 = 7.89%
#  gc.nim: usrToCell 10/190 = 5.26%
#  gc.nim: asgnRef 27/190 = 14.21%
#  ambi_all.nim: ambi_all 189/190 = 99.47%
#Entry: 5/15 Calls: 9/190 = 4.74% [sum: 152; 152/190 = 80.00%]
#  comparisons.nim: <% 13/190 = 6.84%
#  gc.nim: newObj 53/190 = 27.89%
#  system.nim: substr 99/190 = 52.11%
#  ambi_all.nim: ambi_all 189/190 = 99.47%
#Entry: 6/15 Calls: 8/190 = 4.21% [sum: 160; 160/190 = 84.21%]
#  gc.nim: newObj 53/190 = 27.89%
#  system.nim: substr 99/190 = 52.11%
#  ambi_all.nim: ambi_all 189/190 = 99.47%
#Entry: 7/15 Calls: 8/190 = 4.21% [sum: 168; 168/190 = 88.42%]
#  arithmetics.nim: +% 16/190 = 8.42%
#  gc.nim: incRef 8/190 = 4.21%
#  gc.nim: asgnRef 27/190 = 14.21%
#  ambi_all.nim: ambi_all 189/190 = 99.47%
#Entry: 8/15 Calls: 5/190 = 2.63% [sum: 173; 173/190 = 91.05%]
#  arithmetics.nim: +% 16/190 = 8.42%
#  gc.nim: cellToUsr 5/190 = 2.63%
#  gc.nim: newObj 53/190 = 27.89%
#  system.nim: substr 99/190 = 52.11%
#  ambi_all.nim: ambi_all 189/190 = 99.47%
#Entry: 9/15 Calls: 5/190 = 2.63% [sum: 178; 178/190 = 93.68%]
#  arithmetics.nim: -% 15/190 = 7.89%
#  gc.nim: decRef 9/190 = 4.74%
#  gc.nim: asgnRef 27/190 = 14.21%
#  ambi_all.nim: ambi_all 189/190 = 99.47%
#Entry: 10/15 Calls: 4/190 = 2.11% [sum: 182; 182/190 = 95.79%]
#  comparisons.nim: <% 13/190 = 6.84%
#  gc.nim: decRef 9/190 = 4.74%
#  gc.nim: asgnRef 27/190 = 14.21%
#  ambi_all.nim: ambi_all 189/190 = 99.47%
#Entry: 11/15 Calls: 3/190 = 1.58% [sum: 185; 185/190 = 97.37%]
#  ambi_all.nim: isAmbi 3/190 = 1.58%
#  ambi_all.nim: ambi_all 189/190 = 99.47%
#Entry: 12/15 Calls: 2/190 = 1.05% [sum: 187; 187/190 = 98.42%]
#  arithmetics.nim: +% 16/190 = 8.42%
#  gc.nim: newObj 53/190 = 27.89%
#  system.nim: substr 99/190 = 52.11%
#  ambi_all.nim: ambi_all 189/190 = 99.47%
