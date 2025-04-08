include("./gaussianbeam.jl")
using .GaussianBeam

using Plots

# variables
n = 1       # medium refraction index
λ1 = 488e-9 # 1P laser wavelength
λ2 = 915e-9 # 2P laser wavelength

# optimal waist

# width at 200 µm for several waist values 
d = 200e-6
waists = range(3e-6, 9e-6, length=1000)
a = map(x -> gaussian_width(n,d,x,λ1), waists)
b = map(x -> gaussian_width(n,d,x,λ2), waists)

# plot and save figure for optimal waist
plot(waists*1e6, a*1e6, label="488 nm", legend=:bottomright, lw=3)
plot!(waists*1e6, b*1e6, label="915 nm", lw=3)
title!("optimal waist for light sheet in water")
xlabel!("waist (µm)")
ylabel!("beam width after 200µm (µm)")
ylims!(6,11)

# savefig("optimal-waist.png")



# # same but expressed as a function of the NA
# θ = range(0.01,0.05; length=1000)
# wa = λ1 ./ (pi .* θ)
# wb = λ2 ./ (pi .* θ)
# a = map(x -> gaussian_width(n,d,x,λ1), wa)
# b = map(x -> gaussian_width(n,d,x,λ2), wb)
# # θ waists*1e6
# # xlabel!("N.A")