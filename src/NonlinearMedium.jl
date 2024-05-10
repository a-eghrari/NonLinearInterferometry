abstract type Medium end

struct NonlinearMedium{N, T <: Real} <: Medium
    n::N
    length::T
    θ::T
    NonlinearMedium{N, T}() where {N, T <: Real} = new(x->1, 1e-3, 0.0)
    NonlinearMedium{N, T}(n) where {N, T <: Real} = new(n, 1e-3, 0.0)
    NonlinearMedium{N, T}(n, length, θ) where {N, T <: Real} = new(n, length, θ)
end

NonlinearMedium() = NonlinearMedium{Function, Float64}(x->1, x->1, 1e-2, 0.0)
NonlinearMedium(n::N) where {N} = NonlinearMedium{N, Float64}(n, 1e-3, 0.0)
NonlinearMedium(n::N, length::T, θ::T) where {N, T <: Real} = NonlinearMedium{N, T}(n, length, θ)

struct BiNonlinearMedium{N, T <: Real} <: Medium
    nₒ::N
    nₑ::N
    length::T
    θ::T
    BiNonlinearMedium{N, T}() where {N, T <: Real} = new(x->1, x->1, 1e-3, 0.0)
    BiNonlinearMedium{N, T}(nₒ, nₑ) where {N, T <: Real} = new(nₒ, nₑ, 1e-3, 0.0)
    BiNonlinearMedium{N, T}(nₒ, nₑ, length, θ) where {N, T <: Real} = new(nₒ, nₑ, length, θ)
end

BiNonlinearMedium() = BiNonlinearMedium{Function, Float64}(x->1, x->1, 1e-2, 0.0)
BiNonlinearMedium(nₒ::N, nₑ::N) where {N} = BiNonlinearMedium{N, Float64}(nₒ, nₑ, 1e-3, 0.0)
BiNonlinearMedium(nₒ::N, nₑ::N, length::T, θ::T) where {N, T <: Real} = BiNonlinearMedium{N, T}(nₒ, nₑ, length, θ)

function (material::NonlinearMedium)(ω)
    material.n(ω)
end

function (material::BiNonlinearMedium)(ω)
    material.nₒ(ω), material.nₑ(ω)
end