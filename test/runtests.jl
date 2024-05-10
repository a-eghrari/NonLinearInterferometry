names = [
    "NonlinearMedium_test.jl"
]

for name=names
    if endswith(name, "_test.jl")
        include(name)
    end
end