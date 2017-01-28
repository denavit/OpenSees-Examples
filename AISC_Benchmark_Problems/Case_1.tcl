model BasicBuilder -ndm 2 -ndf 3

node 1 0.0   0.0
node 2 0.0  42.0
node 3 0.0  84.0
node 4 0.0 126.0
node 5 0.0 168.0
node 6 0.0 210.0
node 7 0.0 252.0
node 8 0.0 294.0 
node 9 0.0 336.0

fix 1 1 1 0
fix 9 1 0 0

section Elastic 1 29000 14.1 484
geomTransf Corotational 1

element dispBeamColumn 1 1 2 3 1 1
element dispBeamColumn 2 2 3 3 1 1
element dispBeamColumn 3 3 4 3 1 1
element dispBeamColumn 4 4 5 3 1 1
element dispBeamColumn 5 5 6 3 1 1
element dispBeamColumn 6 6 7 3 1 1
element dispBeamColumn 7 7 8 3 1 1
element dispBeamColumn 8 8 9 3 1 1 

timeSeries Linear 1
pattern Plain 1 1 {
    eleLoad -ele 1 -type -beamUniform [expr -0.200/12]
    eleLoad -ele 2 -type -beamUniform [expr -0.200/12]
    eleLoad -ele 3 -type -beamUniform [expr -0.200/12]
    eleLoad -ele 4 -type -beamUniform [expr -0.200/12]
    eleLoad -ele 5 -type -beamUniform [expr -0.200/12]
    eleLoad -ele 6 -type -beamUniform [expr -0.200/12]
    eleLoad -ele 7 -type -beamUniform [expr -0.200/12]
    eleLoad -ele 8 -type -beamUniform [expr -0.200/12]
}

constraints Transformation
numberer Plain
system UmfPack
test NormDispIncr 1.0e-6 30 0
algorithm Newton
integrator LoadControl 0.1
analysis Static
analyze 10

loadConst -time 0.0

set Mmid [lindex [eleResponse 4 forces] 5]
set Dmid [nodeDisp 5 1]
puts [format "Axial Force, P = %.0f kips" [getTime]]
puts [format "Mid-height moment, Mmid = %.0f kip-in" $Mmid] 
puts [format "   compared to 235 kip-in, a %.2f%% difference" [expr 100*(235-$Mmid)/235]]
puts [format "Mid-height displacement, Dmid = %.3f in" $Dmid]
puts [format "   compared to 0.197 in, a %.2f%% difference\n" [expr 100*(0.197-$Dmid)/0.197]]

timeSeries Linear 2
pattern Plain 2 2 {
    load 9 0 -1 0
}

integrator LoadControl 15.0
analyze 10

set Mmid [lindex [eleResponse 4 forces] 5]
set Dmid [nodeDisp 5 1]
puts [format "Axial Force, P = %.0f kips" [getTime]]
puts [format "Mid-height moment, Mmid = %.0f kip-in" $Mmid] 
puts [format "   compared to 269 kip-in, a %.2f%% difference" [expr 100*(269-$Mmid)/269]]
puts [format "Mid-height displacement, Dmid = %.3f in" $Dmid]
puts [format "   compared to 0.224 in, a %.2f%% difference\n" [expr 100*(0.224-$Dmid)/0.224]]

analyze 10

set Mmid [lindex [eleResponse 4 forces] 5]
set Dmid [nodeDisp 5 1]
puts [format "Axial Force, P = %.0f kips" [getTime]]
puts [format "Mid-height moment, Mmid = %.0f kip-in" $Mmid] 
puts [format "   compared to 313 kip-in, a %.2f%% difference" [expr 100*(313-$Mmid)/313]]
puts [format "Mid-height displacement, Dmid = %.3f in" $Dmid]
puts [format "   compared to 0.261 in, a %.2f%% difference\n" [expr 100*(0.261-$Dmid)/0.261]]

analyze 10

set Mmid [lindex [eleResponse 4 forces] 5]
set Dmid [nodeDisp 5 1]
puts [format "Axial Force, P = %.0f kips" [getTime]]
puts [format "Mid-height moment, Mmid = %.0f kip-in" $Mmid] 
puts [format "   compared to 375 kip-in, a %.2f%% difference" [expr 100*(375-$Mmid)/375]]
puts [format "Mid-height displacement, Dmid = %.3f in" $Dmid]
puts [format "   compared to 0.311 in, a %.2f%% difference\n" [expr 100*(0.311-$Dmid)/0.311]]

puts "Analysis Complete!"