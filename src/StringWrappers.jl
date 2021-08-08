"""
    abstract type StringWrapper <: AbstractString end

Provides default `sw::StringWrapper<:AbstractString` API methods defering to `representation(sw)` call, by default `sw.x`.
"""
abstract type StringWrapper <: AbstractString end
@inline representation(sw::StringWrapper) = sw.x

@inline Base.@propagate_inbounds Base.firstindex(sw::StringWrapper) =
    firstindex(representation(sw))
@inline Base.@propagate_inbounds Base.lastindex(sw::StringWrapper) =
    lastindex(representation(sw))
@inline Base.@propagate_inbounds Base.length(sw::StringWrapper) =
    length(representation(sw))
@inline Base.@propagate_inbounds Base.ncodeunits(sw::StringWrapper) =
    ncodeunits(representation(sw))
@inline Base.@propagate_inbounds Base.sizeof(sw::StringWrapper) =
    sizeof(representation(sw))

@inline Base.@propagate_inbounds Base.getindex(sw::StringWrapper,i::Integer) =
    getindex(representation(sw),i)
@inline Base.@propagate_inbounds Base.codeunit(s::StringWrapper, i::Integer) =
    codeunit(representation(sw), i)
@inline Base.@propagate_inbounds Base.isvalid(sw::StringWrapper,i::Int) =
    isvalid(representation(sw), i)

@inline Base.@propagate_inbounds Base.prevind(sw::StringWrapper,i::Int,n::Int) =
    prevind(representation(sw),i,n)
@inline Base.@propagate_inbounds Base.nextind(sw::StringWrapper,i::Int,n::Int) =
    nextind(representation(sw),i,n)
@inline Base.@propagate_inbounds Base.prevind(sw::StringWrapper,i::Int) =
    prevind(representation(sw),i)
@inline Base.@propagate_inbounds Base.nextind(sw::StringWrapper,i::Int) =
    nextind(representation(sw),i)
@inline Base.@propagate_inbounds Base.thisind(sw::StringWrapper,i::Int) =
    thisind(representation(sw), i)


@inline Base.@propagate_inbounds Base.iterate(sw::StringWrapper) =
    iterate(representation(sw))
@inline Base.@propagate_inbounds Base.iterate(sw::StringWrapper,i::Integer) =
    iterate(representation(sw),i)
@inline Base.@propagate_inbounds Base.SubString(sw::StringWrapper,start::Int,stop::Int) =
    SubString(representation(sw),start,stop)


