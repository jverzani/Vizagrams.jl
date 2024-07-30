"""
infer_xy_axis_domain_q(data)

Given a dataset, it infers the domain
"""
function infer_xy_axis_domain_q(data)
    dmin, dmax = minimum(data), maximum(data)
    data_range = dmax - dmin

    # Add some extra spacing so that data does not touch the axis
    dmin = dmin - data_range / 10
    dmax = dmax + data_range / 10

    nticks = 5
    tickvalues = generate_tick_labels(dmin, dmax, nticks)

    # Compute the domains based on the tickvalue and 
    domain_min = min(dmin, tickvalues[begin])
    domain_max = max(dmax, tickvalues[end])

    # Compute the domains based on the tickvalue and 
    if abs(dmin - tickvalues[begin]) < data_range / 20
        domain_min = tickvalues[begin]
    end
    if abs(dmax - tickvalues[end]) < data_range / 20
        domain_max = tickvalues[end]
    end
    domain = (domain_min, domain_max)

    return domain
end

"""
infer_scale(;data, framesize, coordinate=:cartesian, variable=nothing, datatype=nothing)

"""
function infer_scale(;
    data,
    codomain_length,
    coordinate=:cartesian,
    variable=nothing,
    datatype=nothing,
    domain=nothing,
    codomain=nothing,
)
    if isnothing(datatype)
        datatype = inferdatatype(data)
    end

    if datatype == :q
        domain = isnothing(domain) ? infer_xy_axis_domain_q(data) : domain
        codomain = isnothing(codomain) ? (0, codomain_length) : codomain
        scale = Linear(; domain=domain, codomain=codomain)
        return scale
    elseif datatype == :n
        domain = isnothing(domain) ? string.(sort(unique(data))) : domain
        interval = codomain_length / length(domain)

        codomain =
            isnothing(codomain) ? (interval / 2, codomain_length - interval / 2) : codomain
        scale = Categorical(; domain=domain, codomain=codomain)
    end
    codomain = isnothing(codomain) ? (0, codomain_length) : codomain
    return Linear(; domain=domain, codomain=codomain)
end
