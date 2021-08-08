push!(LOAD_PATH,"../src")
using Documenter: Documenter, makedocs, deploydocs, doctest, DocMeta
using LazyStrings
using Test

docdir = joinpath(dirname(pathof(LazyStrings)),"../docs/src/")
mandir = joinpath(docdir,"man")
DocMeta.setdocmeta!(LazyStrings, :DocTestSetup, quote
    using TextParse
    using LazyStrings
end; recursive=true)


makedocs(;
         source=docdir,
         modules=[LazyStrings],
         authors="Gregor Kappler",
         repo="https://github.com/gkappler/LazyStrings.jl/blob/{commit}{path}#L{line}",
         sitename="LazyStrings.jl",
         format=Documenter.HTML(;
                                prettyurls=get(ENV, "CI", "false") == "true",
                                canonical="https://gkappler.github.io/LazyStrings.jl",
                                assets=String[],
                                ),
         pages=[
             "Home" => "index.md"
             # "Developer Guide" => "developer.md"
         ],
         )

deploydocs(;
    repo="github.com/gkappler/LazyStrings.jl",
)
