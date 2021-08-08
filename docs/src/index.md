# LazyStrings
provides a fast lazy reverse `AbstractString` interface implementation.

```julia
julia> using LazyStrings

julia> using BenchmarkTools

julia> @btime reverse("JuliaCon")
  28.694 ns (1 allocation: 32 bytes)
"noCailuJ"

julia> @btime reversed("JuliaCon")
  3.167 ns (0 allocations: 0 bytes)
"noCailuJ"

julia> @btime reverse(reverse("JuliaCon"))
  58.530 ns (2 allocations: 64 bytes)
"JuliaCon"

julia> @btime reversed(reversed("JuliaCon"))
  3.734 ns (0 allocations: 0 bytes)
"JuliaCon"
```

The package is used in [CombinedParsers.jl](https://github.com/gkappler/CombinedParsers.jl) for lookbehind parsers.


```@docs
ReversedString
reversed
LazyStrings.reverse_index
firstindex
lastindex
length
ncodeunits
```

```@docs
thisind
prevind
nextind
```

```@docs
iterate
getindex
codeunit
isvalid
SubString
```


References:
- https://discourse.julialang.org/t/what-is-the-interface-of-abstractstring/8937
