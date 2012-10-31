model basic -ndm 1 -ndf 1

# Define Material
uniaxialMaterial Elastic 1 1000.0

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

set totalDisp -0.008
set numSteps 200
integrator DisplacementControl 2 1 [expr $totalDisp/double($numSteps)]
test NormUnbalance 1.0e-2 20 1
analysis Static
analyze $numSteps