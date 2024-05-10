using Test
using NonLinearInterferometry
using CSV, Interpolations
using Downloads

@testset "Testing Generic Material" begin
    material = BiNonlinearMedium()
    @test (1, 1) == material(rand())
end

@testset "Testing Material in NLI's Paper" begin
    c = 3e8;
    L = 5e-4;

    data_nₒ = CSV.File(Downloads.download("https://refractiveindex.info/tmp/database/data-nk/main/LiNbO3/Zelmon-o.csv"))
    data_nₑ = CSV.File(Downloads.download("https://refractiveindex.info/tmp/database/data-nk/main/LiNbO3/Zelmon-e.csv"))

    inter_data_nₑ = linear_interpolation(reverse(2*π*1e6*c./data_nₑ[:wl]), reverse(data_nₑ[:n]))
    inter_data_nₒ = linear_interpolation(reverse(2*π*1e6*c./data_nₑ[:wl]), reverse(data_nₒ[:n]))

    n = BiNonlinearMedium(inter_data_nₒ, inter_data_nₑ, 5e-4, 0.0)
    n1 = BiNonlinearMedium(inter_data_nₒ, inter_data_nₑ)
    n2 = BiNonlinearMedium()
    n3 = NonlinearMedium(inter_data_nₒ, 5e-4, 0.0)

    @test n(3.769911184307751e14) == (2.0508048794821, 2.0025312699385)
end