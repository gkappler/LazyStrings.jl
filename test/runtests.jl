using LazyStrings
using Test

@testset "CharMappedString" begin
    @test lmap(lowercase, "HallO") == "hallo"
    @test lmap(uppercase, "HallO") == "HALLO"
    @test lmap(lowercase,"JuliaCon")[1] ==  map(lowercase,"JuliaCon")[1]

    @test SubString(lmap(lowercase,"JuliaCon"),1:5) ==  SubString(map(lowercase,"JuliaCon"),1:5)
end

@testset "ReversedString" begin
    @testset "prevind, nextind" begin
        s = "abc"
        rs = ReversedString(s)
        for n in 1:5
            i = 0
            @test_throws BoundsError prevind(s,i,n)
            @test_throws BoundsError prevind(rs,i,n)
            for i in 1:4
                if i==1
                    @test prevind(s,i) == prevind(rs,i)
                else
                    @test prevind(s,i,n) == prevind(rs,i,n)
                end
            end
            for i in 0:3
                if i==1
                    @test nextind(s,i) == nextind(rs,i)
                else
                    @test nextind(s,i,n) == nextind(rs,i,n)
                end
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
    @test firstindex(reversed("JuliaCon")) == 1
    @test ncodeunits(reverse("JuliaCon")) == ncodeunits(reversed("JuliaCon"))

    @testset "thisind and unicode" begin
        jr = reverse("Gödel")
        @test thisind(jr,5) == 4
        @test jr[thisind(jr,5)] == 'ö'
        
        jr = reversed("Gödel")
        @test thisind(jr,5) == 5
        @test jr[thisind(jr,5)] == 'ö'
    end

    @test isvalid(reverse("JuliaCon"),1) == isvalid(reversed("JuliaCon"),1)
    @test codeunit(reverse("JuliaCon"),1) == codeunit(reversed("JuliaCon"),1)
    @test isvalid(reverse("JuliaCon"),10) == isvalid(reversed("JuliaCon"),10)

    @test reverse("JuliaCon")[2:4] == reversed("JuliaCon")[2:4]

    @test SubString(reverse("JuliaCon"),2:4) == SubString(reversed("JuliaCon"),2:4) 
    @test SubString(reverse("JuliaCon"),2,4) == SubString(reversed("JuliaCon"),2,4)


    @test LazyStrings.reverse_index("JuliaCon",1) == 1

end

