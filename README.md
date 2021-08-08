# LazyStrings
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://gkappler.github.io/LazyStrings.jl/dev)
[![Build Status](https://travis-ci.org/gkappler/LazyStrings.jl.svg?branch=master)](https://travis-ci.com/github/gkappler/LazyStrings.jl)
[![Codecov](https://codecov.io/gh/gkappler/LazyStrings.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/gkappler/LazyStrings.jl)

## `StringWrapper`
Provides a lazy `abstract type StringWrapper <: AbstractString end` interface implementation,
delegating `AbstractString` API methods
- `firstindex`
- `lastindex`
- `length`
- `ncodeunits`
- `sizeof`

- `getindex`
- `codeunit`
- `isvalid`

- `thisind`
- `prevind`
- `nextind`

- `iterate`
- `SubString`

All you need for a concrete `StringWrapper`: provide a `LazyStrings.representation` method.

These sources have been reviewed for `AbstractString` interface methods.
- https://docs.julialang.org/en/v1/base/strings/
- [What is the Interface of AbstractString?](https://discourse.julialang.org/t/what-is-the-interface-of-abstractstring/8937)
I did not find any official table of API functions -- please add methods in a PR if the API is missing what you need.


Note: 
- `*, ^, repeat` is not provided
- [findnext(f, ::AbstractString, ::Int) ignores specialised nextind #26202](https://github.com/JuliaLang/julia/issues/26202), is not tested

The package is used in [CombinedParsers.jl](https://github.com/gkappler/CombinedParsers.jl) for lookbehind parsers and parsers on a lazyly transformed `String` (e.g. `lowercase`).
[ReversedStrings.jl](https://github.com/gkappler/ReversedStrings.jl/) was the deprecated and moved into this package.

## `CharMappedString`

```julia
julia> using LazyStrings

julia> using BenchmarkTools

julia> @btime lmap(lowercase,"JuliaCon")[1]
  6.706 ns (0 allocations: 0 bytes)
'j': ASCII/Unicode U+006A (category Ll: Letter, lowercase)

julia> @btime map(lowercase,"JuliaCon")[1]
  93.681 ns (3 allocations: 144 bytes)
'j': ASCII/Unicode U+006A (category Ll: Letter, lowercase)
```

## `ReversedString`

A lazy `reverse` implementation
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
