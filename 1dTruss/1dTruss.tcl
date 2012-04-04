model basic -ndm 1 -ndf 1

# Define Material
set Es 29000.0
uniaxialMaterial Elastic 1 $Es

# Define Nodes
node 1 0.0
node 2 1.0

# Define Boundary Conditions
fix  1 1

# Define Elements
element truss 1 1 2 1.0 1

# Define Recorders
recorder Node -file 1dTruss_Displ.out -node 2 -dof 1 disp
recorder Node -file 1dTruss_Force.out -node 1 -dof 1 reaction

# Apply loads
pattern Plain 1 Linear {
  load 2 1.0
}

# Analysis Options
system UmfPack
constraints Transformation
test NormUnbalance 1.0e-6 20 1
algorithm Newton 
numberer Plain
integrator LoadControl 0.1
analysis Static
analyze 10


puts "Analysis Finished!"
puts "Final Displacement [nodeDisp 2 1]"