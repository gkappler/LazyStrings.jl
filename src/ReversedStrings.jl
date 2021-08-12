using AutoHashEquals

export ReversedString, reversed
"""
    ReversedString{V}<:AbstractString

Lazy reversed `V` struct holding representation and caching `lastindex`.
"""
@auto_hash_equals struct ReversedString{V}<:AbstractString
    representation::V
    lastindex::Int
    ReversedString(x) =
        # if lastindex(x) == 1
        #     x
        # else
        new{typeof(x)}(x, lastindex(x))
        ##end
end

"""
    reversed(x::AbstractString)

A lazy implementation of `Base.reverse` for `String`s.
"""
reversed(x::ReversedString) = x.representation
reversed(x::AbstractString) = ReversedString(x)

"""
    reverse_index(x::ReversedString,i)

Return corresponding index in unreversed String `x.lastindex-i+1`.
"""
@inline function reverse_index(x::ReversedString,i)
    ri = x.lastindex-i+1
end

"""
    reverse_index(x::AbstractString,i)

Return original index `i`.
"""
@inline reverse_index(x::AbstractString,i) =
    i

"""
    Base.SubString(x::ReversedString,start::Int,stop::Int)

Create a reversed `SubString` using [`reverse_index`](@ref).
"""
@inline Base.SubString(x::ReversedString,start::Int,stop::Int) =
    reversed(SubString(x.representation, reverse_index(x, stop), reverse_index(x, start)))


"""
    Base.ncodeunits(x::ReversedString)

`ncodeunits(x.representation)`
"""
@inline Base.ncodeunits(x::ReversedString) = ncodeunits(x.representation)


"""
    Base.ncodeunits(x::ReversedString)

`codeunit(x.representation,`[`reverse_index`](@ref)`(x,i))`.
"""
@inline Base.codeunit(x::ReversedString, i::Integer) =
    codeunit(x.representation, reverse_index(x,i))

"""
    Base.isvalid(x::ReversedString,i::Int)

`isvalid(x.representation,`[`reverse_index`](@ref)`(x,i))`.
"""
@inline Base.isvalid(x::ReversedString,i::Int) =
    isvalid(x.representation,reverse_index(x,i))

"""
    Base.firstindex(x::ReversedString)

1
"""
@inline Base.firstindex(x::ReversedString) = 1

"""
    Base.lastindex(x::ReversedString)

cached `x.lastindex`.
"""
@inline Base.lastindex(x::ReversedString) = x.lastindex


"""
    Base.length(x::ReversedString)

`length(x.representation)`
"""
@inline Base.length(s::ReversedString) =
    length(s.representation)

"""
    Base.getindex(x::ReversedString,is::UnitRange{<:Integer})

`ReversedString` of `getindex` on representation.
!!! note
    `getindex` is creating a new `String` representation.
    See [`SubString`](@ref)
"""
@inline Base.getindex(x::ReversedString,is::UnitRange{<:Integer}) =
    reversed(getindex(x.representation,reverse_index(x,is.stop):reverse_index(x,is.start)))


"""
    Base.getindex(x::ReversedString,i::Integer)

`getindex(x.representation,`[`reverse_index`](@ref)`(x,i))`.
"""
@inline Base.getindex(x::ReversedString,i::Integer) =
    getindex(x.representation,reverse_index(x,i))

"""
    Base.thisind(x::ReversedString,i::Integer)

[`reverse_index`](@ref)`(thisind(x.representation,`[`reverse_index`](@ref)`(x,i)))`.
"""
@inline function Base.thisind(x::ReversedString,i::Int)
    ri = reverse_index(x, i)
    reverse_index(x, thisind(x.representation, ri))
end

"""
    Base.nextind(x::ReversedString,i[,n=1])

[`reverse_index`](@ref)`(nextind(x.representation,`[`reverse_index`](@ref)`(x,i))[,n])`.
"""
@inline function Base.nextind(x::ReversedString,i::Int)
    ri = reverse_index(x, i)
    reverse_index(x, prevind(x.representation, ri))
end

@inline function Base.nextind(x::ReversedString,i::Int,n::Int)
    ri = reverse_index(x, i)
    reverse_index(x, prevind(x.representation, ri, n))
end

"""
    Base.prevind(x::ReversedString,i[,n=1])

[`reverse_index`](@ref)`(prevind(x.representation,`[`reverse_index`](@ref)`(x,i))[,n])`.
"""
@inline function Base.prevind(x::ReversedString,i::Int)
    ri = reverse_index(x, i)
    reverse_index(x, nextind(x.representation, ri))
end

@inline function Base.prevind(x::ReversedString,i::Int,n::Int)
    ri = reverse_index(x, i)
    reverse_index(x,nextind(x.representation, ri, n))
end

"""
    Base.iterate(x::ReversedString[, state])

Iterate lazy reversed string.
"""
@inline Base.iterate(x::ReversedString) =
    iterate(x,1)

@inline Base.iterate(x::ReversedString,i::Int) =
    if reverse_index(x,i) >= 1 && reverse_index(x,i) <= lastindex(x) # ? <=
        x[i], nextind(x,i)
    else
        nothing
    end

