model basic -ndm 1 -ndf 1

# Define Material
uniaxialMaterial Elastic 1 1000.0
#uniaxialMaterial shenSteel01 1 29000 42 58 0.05 44.52 228 0.175 -0.553 6.47 34.8 0.0635 1.0 0.07 10000.0
#uniaxialMaterial changManderConcrete01 1 -4.00 -0.003 4000.0 3.0 3.0 0.1 0.00005 3.0 3.0

# Define Nodes
node 1 0.0
fix  1 1
node 2 1.0

# Define Elements
element truss 1 1 2 1.0 1

# Define Recorders
recorder Node -file materialTest_Displ.out -node 2 -dof 1 disp
recorder Node -file materialTest_Force.out -node 1 -dof 1 reaction

# Apply loads
pattern Plain 1 Linear {
  load 2 1.0
}

# Analysis Options
system UmfPack
constraints Transformation
test NormUnbalance 1.0e-4 20 1
algorithm Newton 
numberer Plain

set totalDisp -0.002
set numSteps 200
integrator DisplacementControl 2 1 [expr $totalDisp/double($numSteps)]
test NormUnbalance 1.0e-2 20 0
analysis Static
analyze $numSteps

puts "\nAnalysis Complete:"
puts "Final Strain: [format %5f [nodeDisp 2 1]]"
puts "Final Stress: [format %5f [getTime]]"