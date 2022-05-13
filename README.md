Ambi
=======

This is a repo containing 5 progressively faster implementations of a 180deg ambigram generator. I set out to write the faster ambigram generator as possible. Sadly, as I started implementing, the bottleneck was reading lines from a text file, the ambigram specifics were pretty quick. This lead to me writing progressively faster readers. 

The input to all these programs is the filename of a text file the dictionary of words to search across. One line per word.

`ambi.nim` - This is the naive implementation that I started with. Here I focused on code style and ease-of-development over speed.

`ambi_all.nim` - This is the first attempt at optimization. It's also a naive approach but it loads the entire wordlist into memory before processing.

`ambi_fast.nim` - This is a faster variant that loads the entire wordlist into memory. It is faster by avoiding `split` in favour of looping over words manually and using slices into string.

`ambi_fastcull.nim` -  This is the fastest variant. It loads the entire wordlist into memory, and does as little processing as possible.

`ambi_opt.nim` - This implementation tries to find a balance between speed of generating ambigrams and memory usage. In general it's performance can almost match fastcull, but with constant memory usage.

I used an ~30MB wordlist with 2,834,369 words in it.

```
❯ hyperfine --warmup 2 './ambi wordss.txt' './ambi_all wordss.txt' './ambi_fast wordss.txt' './ambi_fastcull wordss.txt' './ambi_opt wordss.txt'
Benchmark 1: ./ambi wordss.txt
  Time (mean ± σ):     475.9 ms ±   2.1 ms    [User: 468.1 ms, System: 8.0 ms]
  Range (min … max):   472.0 ms … 479.1 ms    10 runs

Benchmark 2: ./ambi_all wordss.txt
  Time (mean ± σ):     229.6 ms ±   1.4 ms    [User: 213.3 ms, System: 16.4 ms]
  Range (min … max):   226.3 ms … 231.4 ms    13 runs

Benchmark 3: ./ambi_fast wordss.txt
  Time (mean ± σ):     213.3 ms ±   1.2 ms    [User: 197.7 ms, System: 15.8 ms]
  Range (min … max):   211.6 ms … 215.1 ms    13 runs

Benchmark 4: ./ambi_fastcull wordss.txt
  Time (mean ± σ):     106.9 ms ±   1.2 ms    [User: 92.1 ms, System: 15.0 ms]
  Range (min … max):   104.3 ms … 110.6 ms    27 runs

Benchmark 5: ./ambi_opt wordss.txt
  Time (mean ± σ):     120.8 ms ±   1.6 ms    [User: 111.3 ms, System: 9.6 ms]
  Range (min … max):   118.8 ms … 126.6 ms    24 runs

Summary
  './ambi_fastcull wordss.txt' ran
    1.13 ± 0.02 times faster than './ambi_opt wordss.txt'
    2.00 ± 0.03 times faster than './ambi_fast wordss.txt'
    2.15 ± 0.03 times faster than './ambi_all wordss.txt'
    4.45 ± 0.05 times faster than './ambi wordss.txt'
```

Nim really shows it's power here. The first 4 implementation are (in my opinion) quite easy to read and understand. The fourth shows that Nim can still expose "lower level" details when necessary for performance (arguably it's also quite simple).
