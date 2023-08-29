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
     oriole_visibility   362.000  i/100ms
  oriole_no_visibility   488.000  i/100ms
               bluejay     1.766k i/100ms
  Calculating -------------------------------------
     oriole_visibility      3.682k (± 2.3%) i/s -     18.462k in   5.017324s
  oriole_no_visibility      4.992k (± 1.3%) i/s -     25.376k in   5.083988s
               bluejay     18.240k (± 3.1%) i/s -     91.832k in   5.039693s

  Comparison:
               bluejay:    18239.9 i/s
  oriole_no_visibility:     4992.3 i/s - 3.65x  slower
     oriole_visibility:     3681.7 i/s - 4.95x  slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
     oriole_visibility    22.648k memsize (   120.000  retained)
                         264.000  objects (     2.000  retained)
                          15.000  strings (     0.000  retained)
  oriole_no_visibility    12.656k memsize (     4.000k retained)
                         166.000  objects (    56.000  retained)
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
     oriole_visibility   234.000  i/100ms
  oriole_no_visibility   323.000  i/100ms
               bluejay     1.804k i/100ms
  Calculating -------------------------------------
     oriole_visibility      2.403k (± 3.3%) i/s -     12.168k in   5.069266s
  oriole_no_visibility      3.274k (± 1.9%) i/s -     16.473k in   5.033067s
               bluejay     18.418k (± 2.1%) i/s -     93.808k in   5.095735s

  Comparison:
               bluejay:    18417.7 i/s
  oriole_no_visibility:     3274.2 i/s - 5.63x  slower
     oriole_visibility:     2403.1 i/s - 7.66x  slower

  Profiling Ruby memory allocations:
  Calculating -------------------------------------
     oriole_visibility    22.648k memsize (     7.680k retained)
                         264.000  objects (   104.000  retained)
                          15.000  strings (    12.000  retained)
  oriole_no_visibility    12.656k memsize (     4.960k retained)
                         166.000  objects (    63.000  retained)
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
