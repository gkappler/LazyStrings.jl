module LazyStrings

# Write your package code here.
export StringWrapper
include("StringWrappers.jl")

export ReversedStrings
include("ReversedStrings.jl")

export CharMappedString
"""
    CharMappedString(f::Function,x) <: AbstractString

String implementation lazily transforming characters.
Used for parsing with [`MappedSequenceParser`](@ref).
"""
struct CharMappedString{S<:AbstractString,M<:Function} <: StringWrapper
    x::S
    f::M
    function CharMappedString(f::Function,x::AbstractString)
        new{typeof(x),typeof(f)}(x,f)
    end
end

export lmap
lmap(f::Function,x::AbstractString) =
    CharMappedString(f::Function,x::AbstractString)

tuple_pos(i) = i[1]
tuple_state(i) = i[2]

@inline Base.@propagate_inbounds Base.getindex(x::CharMappedString,i::Integer) =
    x.f(getindex(x.x,i))
@inline Base.@propagate_inbounds Base.iterate(x::CharMappedString{<:AbstractString}) =
    let i=iterate(x.x)
        i===nothing && return nothing
        x.f(tuple_pos(i)), tuple_state(i)
    end
@inline Base.@propagate_inbounds Base.iterate(x::CharMappedString{<:AbstractString},i::Integer) =
    let j=iterate(x.x,i)
        j===nothing && return nothing
        x.f(tuple_pos(j)), tuple_state(j)
    end
@inline Base.@propagate_inbounds Base.SubString(x::CharMappedString,start::Int,stop::Int) =
    CharMappedString(SubString(x.x,start,stop), x.f)

end
