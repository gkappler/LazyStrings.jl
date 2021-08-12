var documenterSearchIndex = {"docs":
[{"location":"#StringWrapper","page":"Home","title":"StringWrapper","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Provides a lazy abstract type StringWrapper <: AbstractString end interface implementation, delegating AbstractString API methods","category":"page"},{"location":"","page":"Home","title":"Home","text":"index boundaries and sizes: firstindex, lastindex, length, ncodeunits, sizeof\ngetting elements getindex, iterate, codeunit\ncodeunits and indices: isvalid, thisind, prevind, nextind\nSubString","category":"page"},{"location":"","page":"Home","title":"Home","text":"LazyStrings.jl provides similar functionality for AbstractStrings  as LazyArrays.jl for Vectors.","category":"page"},{"location":"","page":"Home","title":"Home","text":"These sources have been reviewed for AbstractString interface methods.","category":"page"},{"location":"","page":"Home","title":"Home","text":"https://docs.julialang.org/en/v1/base/strings/\nWhat is the Interface of AbstractString?","category":"page"},{"location":"","page":"Home","title":"Home","text":"I did not find any official table of API functions – please add methods in a PR if the API is missing what you need.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Note: ","category":"page"},{"location":"","page":"Home","title":"Home","text":"*, ^, repeat is not provided\nfindnext(f, ::AbstractString, ::Int) ignores specialised nextind #26202, is not tested","category":"page"},{"location":"","page":"Home","title":"Home","text":"The package is used in CombinedParsers.jl for lookbehind parsers and parsers on a lazyly transformed String (e.g. lowercase). ReversedStrings.jl was the deprecated and moved into this package.","category":"page"},{"location":"#Custom-StringWrapper","page":"Home","title":"Custom StringWrapper","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"All you need is provide a LazyStrings.representation method.","category":"page"},{"location":"","page":"Home","title":"Home","text":"LazyStrings.StringWrapper","category":"page"},{"location":"#LazyStrings.StringWrapper","page":"Home","title":"LazyStrings.StringWrapper","text":"abstract type StringWrapper <: AbstractString end\n\nProvides default sw::StringWrapper<:AbstractString API methods defering to representation(sw) call, by default sw.x.\n\n\n\n\n\n","category":"type"},{"location":"#Lazy-CharMappedString","page":"Home","title":"Lazy CharMappedString","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"LazyStrings.CharMappedString","category":"page"},{"location":"#LazyStrings.CharMappedString","page":"Home","title":"LazyStrings.CharMappedString","text":"CharMappedString(f::Function,x) <: AbstractString\n\nString implementation lazily transforming characters. Used for parsing with MappedSequenceParser.\n\n\n\n\n\n","category":"type"},{"location":"","page":"Home","title":"Home","text":"julia> using LazyStrings\n\njulia> using BenchmarkTools\n\njulia> @btime lmap(lowercase,\"JuliaCon\")[1]\n  6.706 ns (0 allocations: 0 bytes)\n'j': ASCII/Unicode U+006A (category Ll: Letter, lowercase)\n\njulia> @btime map(lowercase,\"JuliaCon\")[1]\n  93.681 ns (3 allocations: 144 bytes)\n'j': ASCII/Unicode U+006A (category Ll: Letter, lowercase)","category":"page"},{"location":"#Lazy-ReversedString","page":"Home","title":"Lazy ReversedString","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"julia> using LazyStrings\n\njulia> using BenchmarkTools\n\njulia> @btime reverse(\"JuliaCon\")\n  28.694 ns (1 allocation: 32 bytes)\n\"noCailuJ\"\n\njulia> @btime reversed(\"JuliaCon\")\n  3.167 ns (0 allocations: 0 bytes)\n\"noCailuJ\"\n\njulia> @btime reverse(reverse(\"JuliaCon\"))\n  58.530 ns (2 allocations: 64 bytes)\n\"JuliaCon\"\n\njulia> @btime reversed(reversed(\"JuliaCon\"))\n  3.734 ns (0 allocations: 0 bytes)\n\"JuliaCon\"","category":"page"},{"location":"","page":"Home","title":"Home","text":"ReversedString\nreversed\nLazyStrings.reverse_index\nfirstindex\nlastindex\nlength\nncodeunits","category":"page"},{"location":"#LazyStrings.ReversedString","page":"Home","title":"LazyStrings.ReversedString","text":"ReversedString{V}<:AbstractString\n\nLazy reversed V struct holding representation and caching lastindex.\n\n\n\n\n\n","category":"type"},{"location":"#LazyStrings.reversed","page":"Home","title":"LazyStrings.reversed","text":"reversed(x::AbstractString)\n\nA lazy implementation of Base.reverse for Strings.\n\n\n\n\n\n","category":"function"},{"location":"#LazyStrings.reverse_index","page":"Home","title":"LazyStrings.reverse_index","text":"reverse_index(x::ReversedString,i)\n\nReturn corresponding index in unreversed String x.lastindex-i+1.\n\n\n\n\n\nreverse_index(x::AbstractString,i)\n\nReturn original index i.\n\n\n\n\n\n","category":"function"},{"location":"#Base.firstindex","page":"Home","title":"Base.firstindex","text":"Base.firstindex(x::ReversedString)\n\n1\n\n\n\n\n\n","category":"function"},{"location":"#Base.lastindex","page":"Home","title":"Base.lastindex","text":"Base.lastindex(x::ReversedString)\n\ncached x.lastindex.\n\n\n\n\n\n","category":"function"},{"location":"#Base.length","page":"Home","title":"Base.length","text":"Base.length(x::ReversedString)\n\nlength(x.representation)\n\n\n\n\n\n","category":"function"},{"location":"#Base.ncodeunits","page":"Home","title":"Base.ncodeunits","text":"Base.ncodeunits(x::ReversedString)\n\nncodeunits(x.representation)\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"thisind\nprevind\nnextind","category":"page"},{"location":"#Base.thisind","page":"Home","title":"Base.thisind","text":"Base.thisind(x::ReversedString,i::Integer)\n\nreverse_index(thisind(x.representation,reverse_index(x,i))).\n\n\n\n\n\n","category":"function"},{"location":"#Base.prevind","page":"Home","title":"Base.prevind","text":"Base.prevind(x::ReversedString,i[,n=1])\n\nreverse_index(prevind(x.representation,reverse_index(x,i))[,n]).\n\n\n\n\n\n","category":"function"},{"location":"#Base.nextind","page":"Home","title":"Base.nextind","text":"Base.nextind(x::ReversedString,i[,n=1])\n\nreverse_index(nextind(x.representation,reverse_index(x,i))[,n]).\n\n\n\n\n\n","category":"function"},{"location":"","page":"Home","title":"Home","text":"iterate\ngetindex\ncodeunit\nisvalid\nSubString","category":"page"},{"location":"#Base.iterate","page":"Home","title":"Base.iterate","text":"Base.iterate(x::ReversedString[, state])\n\nIterate lazy reversed string.\n\n\n\n\n\n","category":"function"},{"location":"#Base.getindex","page":"Home","title":"Base.getindex","text":"Base.getindex(x::ReversedString,is::UnitRange{<:Integer})\n\nReversedString of getindex on representation.\n\nnote: Note\ngetindex is creating a new String representation. See SubString\n\n\n\n\n\nBase.getindex(x::ReversedString,i::Integer)\n\ngetindex(x.representation,reverse_index(x,i)).\n\n\n\n\n\n","category":"function"},{"location":"#Base.codeunit","page":"Home","title":"Base.codeunit","text":"Base.ncodeunits(x::ReversedString)\n\ncodeunit(x.representation,reverse_index(x,i)).\n\n\n\n\n\n","category":"function"},{"location":"#Base.isvalid","page":"Home","title":"Base.isvalid","text":"Base.isvalid(x::ReversedString,i::Int)\n\nisvalid(x.representation,reverse_index(x,i)).\n\n\n\n\n\n","category":"function"},{"location":"#Base.SubString","page":"Home","title":"Base.SubString","text":"Base.SubString(x::ReversedString,start::Int,stop::Int)\n\nCreate a reversed SubString using reverse_index.\n\n\n\n\n\n","category":"type"}]
}