@kwdef struct ParkingGarageSOW{F<:AbstractFloat,I<:Int}
    demand_growth_rate::F = 80.0
    n_years::I = 20
    discount_rate::F = 0.12
end

"""
Demand on opening day is for 750 spaces, and rises linearly at the rate of `demand_growth_rate` spaces/ year
"""
function calculate_demand(t, demand_growth_rate::AbstractFloat)
    return 750 + demand_growth_rate * (t - 1)
end

mutable struct ParkingGarageState{T<:AbstractFloat}
    n_levels::Int
    year::Int
    demand::T
end

function ParkingGarageState()
    return ParkingGarageState(Δn_levels, getindex(year,k), calculate_demand(1, sow.demand_growth_rate))
    #dgrs = [5.0,10.0,15.0,20.0,25.0,30.0,35.0,40.0,45.0,50.0,55.0,60.0,65.0,70.0,75.0,80.0,85.0,90.0,95.0] 
    #for i in 1:length(dgrs)
        #return ParkingGarageState(0, 1, calculate_demand(1, getindex(dgrs,i)))
    #end
end

struct ParkingGarageAction
    Δn_levels::Int
end

abstract type AbstractPolicy end
struct StaticPolicy <: AbstractPolicy
    n_levels::Int
end
struct AdaptivePolicy <: AbstractPolicy
    n_levels_init::Int
end