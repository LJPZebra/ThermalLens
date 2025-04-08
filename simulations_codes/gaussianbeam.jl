module GaussianBeam

export rayleigh_length, gaussian_width, gaussian_intensity, magnification, sprime

# Rayleigh length
function rayleigh_length(n,w0,λ) 
    # w0 waist
    # λ wavelength
    # n index of refraction
    return n * π * w0^2 / λ
end

# beam width
function gaussian_width(n,z,w0,λ)
    # z propagation
    # w0 waist
    # λ wavelength
    # n index of refraction
    zr = rayleigh_length(n,w0,λ)
    w = w0*sqrt(1+(z/zr)^2)
    return w
end

# radial intensity
function gaussian_intensity(n,r,z,w0,λ)
    # r radius
    # z propagation
    # w0 waist
    # λ lambda wavelength
    w = gaussian_width(n,z,w0,λ)
    return (w0/w)^2 * exp(-2*(r/w)^2)
end


# gaussian beam optics

# magnification
function magnification(s,fprime,zr)
    # s algebric distance object-lens
    # fprime lens focal length
    # zr Rayleigh length
    return abs(fprime) / sqrt( (s+fprime)^2 + zr^2 )
end

# algebric distance image-lens
function sprime(s,fprime,zr) 
    # s algebric distance object-lens
    # fprime lens focal length
    # zr Rayleigh length
    return 1 / ( 1/fprime + 1/(s+(zr^2/(s-fprime))) )
    #return (zr^2/fprime - s*(1-s/fprime))/((zr^2/fprime^2)+(1-s/fprime)^2)#TO CHECK ?
end

sprimethinlens(s,fprime,zr) = 1 / (1/fprime + 1/s)

#TODO IN PROGRESS
function flat_refraction_w(w,index_before, index_after)


    return w*[1 0; 0 index_before/index_after]
end



function sample_holder(w)
    n0 = 1;#air
    n1 = 1.5;#glass
    n2 = 1.33#water
    return flat_refraction_w(flat_refraction_w(w,n0,n1),n1,n2)
end




end