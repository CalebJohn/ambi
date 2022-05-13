Ambi
=======

This is a repo containing 5 progressively faster implementations of a 180deg ambigram generator.

`ambi.nim` - This is the naive implementation that I started with. Here I focused on code style and ease-of-development over speed.

`ambi_all.nim` - This is the first attempt at optimization. It's also a naive approach but it loads the entire wordlist into memory before processing.

`ambi_fast.nim` - This is a faster variant that loads the entire wordlist into memory. It is faster by avoiding `split` in favour of looping over words manually and using slices into string.

`ambi_fastcull.nim` - This is the fastest variant. It loads the entire wordlist into memory, and does as little processing as possible.

`ambi_opt.nim` - This implementation tries to find a balance between speed of generating ambigrams and memory usage. In general it's performance can almost match fastcull, but with constant memory usage.