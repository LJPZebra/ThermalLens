#using Revise
include("./grinlens_t.jl")
using .Grinlens_t
using Plots
#using PyPlot

# same plots as grinlensplots, but reworked to fit in the figure presented in the these

## === Calculate Beam_profile(power,time)
#z0s = [0.1:0.1:1]*1e-2
time = [0.001:0.001:0.01; 0.02:0.01:0.5; 1; 2:10:1000]#:20; 25:5:100 ]
#time = [1 2]
#exppows = [0.001,0.213, 0.248, 0.284, 0.319, 0.355,0.5,0.75,1] # experimental powers in watt
exppows = LinRange(0.001,1,9) # experimental powers in watt

#exppows = [0.2, 0.3]
minwidthpos_t = zeros(length(time),length(exppows))
show_plot = 1


for (i,T) in enumerate(time)
    println(T)
    P = map(p -> Parameters(P=p, l=1e-6, w0=4e-6, n=1.33, t=T), exppows) # parameter array
    p = P[1]
    O = propagate.(P) # observables for these parameters
    minwidthpos = map(o->o.minwidthpos-p.z0, O).*1e3 # mm
    minwidthpos_t[i,:] = minwidthpos

    # plot beam profile in water
    p1 = plot(size=(700,400), gridlinewidth=3, thickness_scaling=1.5,palette=:YlOrRd_9)
    ROI = 10000:15770 # ROI for svg
    ROI = 1000:1577 # ROI for svg

    for (i,pow) in enumerate(exppows)
        plot!((P[i].steps[ROI].-P[i].z0).*1e3, +O[i].wonlens[ROI].*1e6, lw=3, legend=false) # mm / µm        #plot!((p.steps[ROI].-p.z0).*1e3, -o.wonlens[ROI].*1e6, lw=3, legend=false)#ff8019a2") # mm / µm
    end
    plot!(minwidthpos, [0,0,0,0,0], seriestype=:scatter, markercolor=:black)
    title!("Beam profile")
    xlabel!("Position (mm)")
    ylabel!("Half waist (µm)")
    ylims!((0,50))
    xlims!((0,3))
    if show_plot == 1
        display(p1)
        #sleep(1)
    end
end
#display(p1)

# === plot focal shift over time for different powers
p2 = plot(size=(700,400), gridlinewidth=3, thickness_scaling=1.5,palette=:YlOrRd_9,xaxis=:log,yaxis=:log, legend=:bottomright)
for (i,pow) in enumerate(exppows)
    plot!(time,minwidthpos_t[:,i],lw=3,label = string(pow) * " W")
end
xlabel!("Time (s)")
ylabel!("Focal shift (mm)")
ylims!((0.01,10))
xlims!((0.001,100))
savefig("Figures/FocalShift_vs_Time_for_different_powers.png")



## === Calculate Beam_profile(time,zo) for a given power

time = [0.000001; 0.001:0.001:0.01; 0.02:0.01:0.5; 1; 2:10:1000]#:20; 25:5:100 ]
z0s = [0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01] #LinRange(2,10,9)/10*1e-2 # experimental powers in watt
exppow = 0.2

minwidthpos_z0 = zeros(length(time),length(z0s))
show_plot = 0
for (i,Z0) in enumerate(z0s)
    println(Z0)
    P = map(T -> Parameters(P=exppow, l=1e-6, w0=4e-6, n=1.33, t=T, z0 = Z0), time) # parameter array
    p = P[1]
    O = propagate.(P) # observables for these parameters
    minwidthpos = map(o->o.minwidthpos-p.z0, O).*1e3 # mm
    minwidthpos_z0[:,i] = minwidthpos
end

# === Plot focal shift over time for different zo
p3 = plot(size=(700,400), gridlinewidth=3, thickness_scaling=1.5,palette=:Blues_9,xaxis=:log,yaxis=:log, legend=:bottomright) #legend=:bottomright
for (i,z0) in enumerate(z0s)
    plot!(time,minwidthpos_z0[:,i],lw=3,label = string(z0*1e3) * " mm")
end
title!("Focal shift different z0")
xlabel!("Time (s)")
ylabel!("Focal shift (mm)")
ylims!((0.01,0.4))
xlims!((0.001,100))
savefig("Figures/FocalShift_vs_Time_for_different_z0.png")

# === Plot normalized focal shift over time for different zo

p4 = plot(size=(700,400), gridlinewidth=3, thickness_scaling=1.5,palette=:Blues_9,xaxis=:log,yaxis=:log, legend=:bottomright) #legend=:bottomright
for (i,z0) in enumerate(z0s)
    plot!(time,minwidthpos_z0[:,i]./minwidthpos_z0[end,i],lw=3,label = string(z0*1e3) * " mm")
end
title!("Focal shift different z0")
xlabel!("Time (s)")
ylabel!("Normalized focal shift (mm)")
ylims!((0.1,1))
xlims!((0.001,10))
savefig("Figures/FocalShiftNormalized_vs_Time_for_different_z0.png")


## === Beam profile for different powers at t = Inf

exppows = [0.05,0.213, 0.248, 0.284, 0.319, 0.355,0.5,0.75,1] # experimental powers in watt
minwidthpos_t = zeros(length(time),length(exppows))
P = map(p -> Parameters(P=p, l=1e-6, w0=3e-6, n=1.33, t=Inf), exppows) # parameter array
p = P[1]
O = propagate.(P) # observables for these parameters
ROI = 10000:15770 # ROI for svg
# plot beam profile in water
p5 = plot(size=(700,400), gridlinewidth=3, thickness_scaling=1.5,palette=:YlOrRd_9)
for (i,pow) in enumerate(exppows)
    plot!((P[i].steps[ROI].-P[i].z0).*1e3, +O[i].wonlens[ROI].*1e6, lw=3,label = string(pow) * " W",  legend=:bottomright) # mm / µm
    minwidthpos = map(o->o.minwidthpos-p.z0, O).*1e3 # mm
    plot!(minwidthpos, [0,0,0,0,0], seriestype=:scatter, markercolor=:black, label="")
end

xlabel!("Position (mm)")
ylabel!("Focal shift (mm)")
ylims!((0,10))
xlims!((0,2))
savefig("Figures/profile_for_different_powers.png")



## === plot normalied focal shift over time for different powers

p6 = plot(size=(700,400), gridlinewidth=3, thickness_scaling=1.5,palette=:YlOrRd_9,xaxis=:log,yaxis=:log)
for (i,P) in enumerate(exppows)
    plot!(time,minwidthpos_t[:,i]./minwidthpos_t[end,i]',label = string(P))
end
xlabel!("Time (s)")
ylabel!("Normalized focal shift")

## === waist position model vs experiments ===
pows = 0.2:0.01:0.38  # pows range for shift computation
P = map(p -> Parameters(P=p, l=1e-8, w0=4e-6, n=1.33), pows)
p = P[1]
O = propagate.(P)

minwidthpos = map(o->o.minwidthpos-p.z0, O).*1e3 # mm
p7 = plot(pows, minwidthpos, label="simulation", lw=5, size=(600,400), legend=:bottomright, gridlinewidth=3, thickness_scaling=1.5) # numerical model

exppows=[0.213, 0.248, 0.284, 0.319, 0.355] # W
expshift=[-130, -80, 0, 50, 110] .* 1e-3 .+ minwidthpos[findfirst(isequal(0.29),pows)]   # mm
# use same shift as in model

#plot!(exppows, expshift, seriestype=:scatter, label="experiment", markersize=10, markerstrokealpha=0) # experimental values

xlabel!("Laser power (W)")
ylabel!("Focal shift (mm)")

savefig("Figures/Shift_vs_Power.png")

## === Test ====
pows = 0.2:0.01:0.38  # pows range for shift computation
waist_values = 1e-6:1e-6:1e-5
p8 = plot(size=(600,400), gridlinewidth=3, thickness_scaling=1.5) # numerical model
plot!(pows,minwidthpos_w05,label="w0=0.5e-6")
plot!(pows,minwidthpos_w1,label="w0=1e-6")
plot!(pows,minwidthpos_w2,label="w0=2e-6")
plot!(pows,minwidthpos_w3,label="w0=3e-6")
plot!(pows,minwidthpos_w4,label="w0=4e-6")
plot!(pows,minwidthpos_w5,label="w0=5e-6")
plot!(pows,minwidthpos_w6,label="w0=6e-6")
plot!(pows,minwidthpos_w7,label="w0=7e-6")
plot!(pows,minwidthpos_w8,label="w0=8e-6")

xlabel!("Laser power (W)")
ylabel!("Focal shift (mm)")
## === waist position model vs experiments Antoine ===
pows = 0.06:0.01:0.400  # pows range for shift computation
P = map(p -> Parameters(P=p, l=1e-6, w0=4e-6, n=1.33), pows)
p = P[1]
O = propagate.(P)

minwidthpos = map(o->o.minwidthpos-p.z0, O).*1e3 # mm
p7 = plot(pows, minwidthpos, label="simulation w0=4", lw=5, size=(600,400), legend=:topleft, gridlinewidth=3, thickness_scaling=1.5) # numerical model

exppows=[0.068, 0.120, 0.171, 0.195, 0.218, 0.242, 0.266, 0.311, 0.356, 0.398] # W
expshift=([270.2, 290.9, 312.7, 317.7, 325.5, 336.1, 345.9, 362.6, 378.6, 399.7] .-325) .* 1e-3 #.+ minwidthpos[findfirst(isequal(0.29),pows)]   # mm
# use same shift as in model

plot!(exppows, expshift, seriestype=:scatter, label="experiment", markersize=10, markerstrokealpha=0) # experimental values

xlabel!("Laser power (W)")
ylabel!("Focal shift (mm)")

savefig("Figures/Shift_vs_Power.png")


## === contribution of each slice ===

P = Parameters(P=0.2, w0=4e-6, l=1e-5, steps=0:1e-5:2e-2)
O = propagate(P)

p8 = plot(P.steps*1e2, O.shift*1e6, lw=3, legend=false, size=(500,400), gridlinewidth=3)
xlabel!("Propagation distance in water (cm)")
ylabel!("Shift per 10µm water layer (µm)")

savefig("Figures/contribution.png")


## === power density in waist along power ===
pows = 0:0.01:1 # pows range for shift computation
P = map(p -> Parameters(P=p, l=1e-6, w0=4e-6, n=1.33), pows)
O = propagate.(P)

minwidth = map(o->o.minwidth, O).*1e3 # mm
p9 = plot(pows, pows./minwidth.^2, lw=3, size=(600,400), legend=false, gridlinewidth=3, thickness_scaling=1.5) # numerical model

xlabel!("Laser Power (W)")
ylabel!("Max Intensity (W/mm²)")

savefig("Figures/MaxIntensityInFocus.png")


## === minimal waist along power ===
pows = [0:0.01:1.4 ; 1.5:0.5:4]# pows range for shift computation
P = map(p -> Parameters(P=p, l=1e-6, w0=4e-6, n=1.33), pows)
O = propagate.(P)

minwidth = map(o->o.minwidth, O).*1e6 # μm
p10 = plot(pows, minwidth, lw=3, size=(600,400), legend=false, gridlinewidth=3, thickness_scaling=1.5) # numerical model
#yaxis!(:log)
xlabel!("Laser Power (W)")
ylabel!("Waist (μm)")
savefig("Figures/MinWaist_vs_Power.png")
xlims!((0,1))
ylims!((0,25))
savefig("Figures/MinWaist_vs_Power_Zoom.png")


# savefig("grinlensplots_these_maxpower.png")

## === focal shift versus z0 (initial position of the beam from entry (m))
z0s = 0.001:0.001:0.01 # pows range for shift computation
P = map(x -> Parameters(z0=x, l=1e-6, w0=4e-6, n=1.33), z0s)
O = propagate.(P)
minwidthpos = map(o->o.minwidthpos, O).*1e3 # mm
minwidthpos = minwidthpos - z0s.*1e3
p11 = plot(z0s.*1e3, minwidthpos, label="simulation numérique", lw=5, size=(600,400), legend=:bottomright, gridlinewidth=3, thickness_scaling=1.5) # numerical model

xlabel!("Initial distance beamwaist to entry(mm)")
ylabel!("Focal shift (mm)")

savefig("Figures/Shift_vs_WaterLength.png")

plot(p1,p2,p3,p4,p5,p6,p6,p7,p8,p9,p10,p11)


## === Propagation through glass

## === focal shift versus z0 (initial position of the beam from entry (m))

z0s = 0.001:0.001:0.01 # z0 range for shift computation
P = map(x -> Parameters(z0=x, l=1e-6, w0=4e-6, n=1.33), z0s)
O = propagate.(P)
minwidthpos = map(o->o.minwidthpos, O).*1e3 # mm
minwidthpos = minwidthpos - z0s.*1e3
p11 = plot(z0s.*1e3, minwidthpos, label="simulation numérique", lw=5, size=(600,400), legend=:bottomright, gridlinewidth=3, thickness_scaling=1.5) # numerical model

xlabel!("Initial distance beamwaist to entry(mm)")
ylabel!("Focal shift (mm)")

