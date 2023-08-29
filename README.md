# `oriole`

> **Warning**
> This is very scrappy and incomplete

## Benchmark

<!---benchmark result start-->
<details>
  <summary>Parse + Execute (Ruby 3.2, YJIT enabled)</summary>

  ```
  Profiling IPS:
  Warming up --------------------------------------
     oriole_visibility   624.000  i/100ms
  oriole_no_visibility   779.000  i/100ms
               bluejay     3.324k i/100ms
  Calculating -------------------------------------
     oriole_visibility      6.205k (± 1.2%) i/s -     31.200k in   5.028634s
  oriole_no_visibility      8.359k (± 1.2%) i/s -     42.066k in   5.033414s
               bluejay     33.629k (± 3.1%) i/s -    169.524k in   5.046559s

  Comparison:
               bluejay:    33628.7 i/s
  oriole_no_visibility:     8358.5 i/s - 4.02x  slower
     oriole_visibility:     6205.4 i/s - 5.42x  slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
     oriole_visibility    22.648k memsize (   720.000  retained)
                         264.000  objects (    10.000  retained)
                          15.000  strings (     1.000  retained)
  oriole_no_visibility    12.656k memsize (     4.880k retained)
                         166.000  objects (    61.000  retained)
                          14.000  strings (    12.000  retained)
               bluejay     5.256k memsize (     5.056k retained)
                          40.000  objects (    35.000  retained)
                           0.000  strings (     0.000  retained)

  Comparison:
               bluejay:       5256 allocated
  oriole_no_visibility:      12656 allocated - 2.41x more
     oriole_visibility:      22648 allocated - 4.31x more
  ```
</details>

<details>
  <summary>Parse + Execute (Ruby 3.2, YJIT disabled)</summary>

  ```
  Profiling IPS:
  Warming up --------------------------------------
     oriole_visibility   423.000  i/100ms
  oriole_no_visibility   580.000  i/100ms
               bluejay     3.383k i/100ms
  Calculating -------------------------------------
     oriole_visibility      4.212k (± 0.9%) i/s -     21.150k in   5.021318s
  oriole_no_visibility      5.773k (± 1.0%) i/s -     29.000k in   5.024171s
               bluejay     32.760k (± 4.2%) i/s -    165.767k in   5.070427s

  Comparison:
               bluejay:    32760.0 i/s
  oriole_no_visibility:     5772.7 i/s - 5.68x  slower
     oriole_visibility:     4212.4 i/s - 7.78x  slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
     oriole_visibility    22.648k memsize (     7.760k retained)
                         264.000  objects (   106.000  retained)
                          15.000  strings (    12.000  retained)
  oriole_no_visibility    12.656k memsize (     5.040k retained)
                         166.000  objects (    65.000  retained)
                          14.000  strings (    12.000  retained)
               bluejay     5.256k memsize (     5.056k retained)
                          40.000  objects (    35.000  retained)
                           0.000  strings (     0.000  retained)

  Comparison:
               bluejay:       5256 allocated
  oriole_no_visibility:      12656 allocated - 2.41x more
     oriole_visibility:      22648 allocated - 4.31x more
  ```
</details>
<!---benchmark result end-->
