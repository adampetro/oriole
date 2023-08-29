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
     oriole_visibility   575.000  i/100ms
  oriole_no_visibility   713.000  i/100ms
               bluejay     3.378k i/100ms
  Calculating -------------------------------------
     oriole_visibility      5.789k (± 1.4%) i/s -     29.325k in   5.066953s
  oriole_no_visibility      7.601k (± 3.0%) i/s -     38.502k in   5.070720s
               bluejay     32.907k (± 4.1%) i/s -    165.522k in   5.039484s

  Comparison:
               bluejay:    32907.0 i/s
  oriole_no_visibility:     7600.7 i/s - 4.33x  slower
     oriole_visibility:     5788.7 i/s - 5.68x  slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
     oriole_visibility    22.648k memsize (   720.000  retained)
                         264.000  objects (    10.000  retained)
                          15.000  strings (     1.000  retained)
  oriole_no_visibility    12.656k memsize (    40.000  retained)
                         166.000  objects (     1.000  retained)
                          14.000  strings (     1.000  retained)
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
     oriole_visibility   363.000  i/100ms
  oriole_no_visibility   457.000  i/100ms
               bluejay     3.152k i/100ms
  Calculating -------------------------------------
     oriole_visibility      3.626k (± 3.6%) i/s -     18.150k in   5.012012s
  oriole_no_visibility      4.887k (± 2.3%) i/s -     24.678k in   5.052241s
               bluejay     32.227k (± 4.8%) i/s -    160.752k in   5.003521s

  Comparison:
               bluejay:    32227.1 i/s
  oriole_no_visibility:     4887.2 i/s - 6.59x  slower
     oriole_visibility:     3626.4 i/s - 8.89x  slower

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
