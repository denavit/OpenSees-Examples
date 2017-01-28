model BasicBuilder -ndm 2 -ndf 3

node 1 0.0   0.0
node 2 0.0  84.0
node 3 0.0 168.0
node 4 0.0 252.0
node 5 0.0 336.0

fix 1 1 1 1

section Elastic 1 29000 14.1 484
geomTransf Corotational 1

element dispBeamColumn 1 1 2 3 1 1
element dispBeamColumn 2 2 3 3 1 1
element dispBeamColumn 3 3 4 3 1 1
element dispBeamColumn 4 4 5 3 1 1

timeSeries Linear 1
pattern Plain 1 1 {
    load 5 1 0 0
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

set Mbase [lindex [eleResponse 1 forces] 2]
set Dtip [nodeDisp 5 1]
puts [format "Axial Force, P = %.0f kips" [getTime]]
puts [format "Base moment, Mbase = %.0f kip-in" $Mbase] 
puts [format "   compared to 336 kip-in, a %.2f%% difference" [expr 100*(336-$Mbase)/336]]
puts [format "Tip displacement, Dtip = %.3f in" $Dtip]
puts [format "   compared to 0.901 in, a %.2f%% difference\n" [expr 100*(0.901-$Dtip)/0.901]]

timeSeries Linear 2
pattern Plain 2 2 {
    load 5 0 -1 0
}

integrator LoadControl 10.0
analyze 10

set Mbase [lindex [eleResponse 1 forces] 2]
set Dtip [nodeDisp 5 1]
puts [format "Axial Force, P = %.0f kips" [getTime]]
puts [format "Base moment, Mbase = %.0f kip-in" $Mbase] 
puts [format "   compared to 469 kip-in, a %.2f%% difference" [expr 100*(469-$Mbase)/469]]
puts [format "Tip displacement, Dtip = %.2f in" $Dtip]
puts [format "   compared to 1.33 in, a %.2f%% difference\n" [expr 100*(1.33-$Dtip)/1.33]]

analyze 5

set Mbase [lindex [eleResponse 1 forces] 2]
set Dtip [nodeDisp 5 1]
puts [format "Axial Force, P = %.0f kips" [getTime]]
puts [format "Base moment, Mbase = %.0f kip-in" $Mbase] 
puts [format "   compared to 598 kip-in, a %.2f%% difference" [expr 100*(598-$Mbase)/598]]
puts [format "Tip displacement, Dtip = %.2f in" $Dtip]
puts [format "   compared to 1.75 in, a %.2f%% difference\n" [expr 100*(1.75-$Dtip)/1.75]]

analyze 5

set Mbase [lindex [eleResponse 1 forces] 2]
set Dtip [nodeDisp 5 1]
puts [format "Axial Force, P = %.0f kips" [getTime]]
puts [format "Base moment, Mbase = %.0f kip-in" $Mbase] 
puts [format "   compared to 848 kip-in, a %.2f%% difference" [expr 100*(848-$Mbase)/848]]
puts [format "Tip displacement, Dtip = %.2f in" $Dtip]
puts [format "   compared to 2.56 in, a %.2f%% difference\n" [expr 100*(2.56-$Dtip)/2.56]]

puts "Analysis Complete!"