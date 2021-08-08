using LazyStrings
using Test

@testset "CharMappedString" begin
    @test CharMappedString(lowercase, "HallO") == "hallo"
    @test CharMappedString(uppercase, "HallO") == "HALLO"
end

using BenchmarkTools
@btime lmap(lowercase,"JuliaCon")[1]
@btime map(lowercase,"JuliaCon")[1]

@testset "ReversedString" begin
    @testset "prevind, nextind" begin
        s = "abc"
        rs = ReversedString(s)
        for n in 1:5
            i = 0
            @test_throws BoundsError prevind(s,i,n)
            @test_throws BoundsError prevind(rs,i,n)
            for i in 1:4
                @test prevind(s,i,n) == prevind(rs,i,n)
            end
            for i in 0:3
                @test nextind(s,i,n) == nextind(rs,i,n)
            end
            i = 5
            @test_throws BoundsError nextind(s,i,n)
            @test_throws BoundsError nextind(rs,i,n)
        end

        s="aän"
        rs = ReversedString(s)
        rs |> collect
        
        @test s[nextind(s,1)] == rs[nextind(rs,1)]
    end
    @test [ c for c in reverse("JuliaCon") ] == [ c for c in reversed("JuliaCon") ]
    @test reversed(reversed("JuliaCon")) == "JuliaCon"
    @test ncodeunits(reverse("JuliaCon")) == ncodeunits(reversed("JuliaCon"))
    @test isvalid(reverse("JuliaCon"),1) == isvalid(reversed("JuliaCon"),1)
    @test isvalid(reverse("JuliaCon"),10) == isvalid(reversed("JuliaCon"),10)

    @test reverse("JuliaCon")[2:4] == reversed("JuliaCon")[2:4]

    @test SubString(reverse("JuliaCon"),2:4) == SubString(reversed("JuliaCon"),2:4) 
    @test SubString(reverse("JuliaCon"),2,4) == SubString(reversed("JuliaCon"),2,4) 
end

