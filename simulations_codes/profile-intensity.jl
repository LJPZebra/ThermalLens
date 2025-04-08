include("./gaussianbeam.jl")
using .GaussianBeam

using Plots

# variables
n = 1       # medium refraction index
λ2 = 915e-9 # 2P laser wavelength

# compute gaussian intensity

f1(z,r) = gaussian_intensity(n,r,z,6.5e-6,λ2)     # intensity
f2(z,r) = gaussian_intensity(n,r,z,6.5e-6,λ2)^2   # intensity squared
zrange = range(-400e-6,400e-6, length=100)      # z range
rrange = range(-20e-6,20e-6, length=100)        # r range
c1 = contour(zrange, rrange, f1, fill=true, levels=200) # contour
c2 = contour(zrange, rrange, f2, fill=true, levels=200) # contour for squared

# plot it with pyplot

plot(c1,c2, layout=(2,1))

# savefig("profile-intensity.png")