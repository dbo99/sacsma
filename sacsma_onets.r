rm(list = ls()) 

### parameters ###

# depletion coeficients 
dc_lowerprim <- 0.085 #lzpk
dc_lowerseco <- .012  #lzsk
dc_upper <- 0.35      #uzk

# percolation related
zperc <- 18  # factor to increase percolation to optimal perc conditions
rexp <- 0.7
# tank sizes
tk_upper_free_tot <- 30      #uzfwm
tk_upper_tension_tot <- 155  #uztwm
tk_lowerprim_free_tot <- 100 #lzfpm
tk_lowerseco_free_tot <- 50  #lzfsm
tk_lower_tension_tot <- 150  #lztwm
tk_lower_cap <- tk_lowerprim_free_tot + tk_lowerseco_free_tot + tk_lower_tension_tot

### derived params ###

# maximum drainage limit (ie baseflow) from lower zone
pbase <- tk_lowerprim_free_tot * dc_lowerprim  +  
         tk_lowerseco_free_tot * dc_lowerseco


### states ###
# tanks #
tk_upper_free_sta <- 20
tk_upper_tension_sta <- 105
tk_lowerprim_free_sta <- 80
tk_lowerseco_free_sta <- 20
tk_lower_tension_sta <- 70


# depletions
uz_wdraw <-  dc_upper * tk_upper_free_sta
lz_prim_wdraw    <-  dc_lowerprim * tk_lowerprim_free_sta
lz_seco_witdraw  <-  dc_lowerseco * tk_lowerprim_free_sta 

# deficiencies
tk_lowerprim_free_defy <- tk_lowerprim_free_tot - tk_lowerprim_free_sta
tk_lowerseco_free_defy <- tk_lowerseco_free_tot - tk_lowerseco_free_sta
tk_lower_tension_defy  <- tk_lower_tension_tot -  tk_lower_tension_sta
tk_lower_defy <- tk_lowerprim_free_defy + tk_lowerseco_free_defy + tk_lower_tension_defy

# non-deep-percolation demand
nondperc_demand <- pbase * ((1 + zperc) * (tk_lower_defy/tk_lower_cap)^rexp)
nondperc <- nondperc_demand * tk_upper_free_sta/tk_upper_free_tot

# adjust tanks
tk_upper_free_sta     <- tk_upper_free_sta - uz_wdraw
tk_lowerprim_free_sta <- tk_lowerprim_free_sta - lz_prim_wdraw
tk_lowerseco_free_sta <-  tk_lowerseco_free_sta - lz_seco_witdraw
