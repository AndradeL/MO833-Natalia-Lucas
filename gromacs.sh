#!/bin/bash

echo "Cleaning previous files"
rm \#*\#;
rm *.top *.pdb *.edr *.gro *.tpr *.mdp *.itp *.log *.trr *.xvg

echo "Getting files from the internet"
wget https://files.rcsb.org/download/1AKI.pdb
wget http://www.mdtutorials.com/gmx/lysozyme/Files/ions.mdp
wget http://www.mdtutorials.com/gmx/lysozyme/Files/minim.mdp
wget http://www.mdtutorials.com/gmx/lysozyme/Files/nvt.mdp
wget http://www.mdtutorials.com/gmx/lysozyme/Files/npt.mdp
wget http://www.mdtutorials.com/gmx/lysozyme/Files/md.mdp

. /usr/local/gromacs/bin/GMXRC

echo "Removing water from solution"
grep -v HOH 1AKI.pdb > 1AKI_clean.pdb

echo "Processing protein (Lysozyme) topology"
echo 15 > in.txt
gmx pdb2gmx -f 1AKI_clean.pdb -o 1AKI_processed.gro -water spce < in.txt

echo "Adding water to solution"
gmx editconf -f 1AKI_processed.gro -o 1AKI_newbox.gro -c -d 1.0 -bt cubic
gmx solvate -cp 1AKI_newbox.gro -cs spc216.gro -o 1AKI_solv.gro -p topol.top

echo "Adding CL ions to neutralize charges"
gmx grompp -f ions.mdp -c 1AKI_solv.gro -p topol.top -o ions.tpr
echo 13 > in.txt
gmx genion -s ions.tpr -o 1AKI_solv_ions.gro -p topol.top -pname NA -nname CL -neutral < in.txt

echo "Energy minimization"
gmx grompp -f minim.mdp -c 1AKI_solv_ions.gro -p topol.top -o em.tpr
gmx mdrun -v -ntmpi $1 -ntomp $2 -nsteps $4 -deffnm em -gpu_id $3
echo "10 0" > in.txt
gmx energy -f em.edr -o potential.xvg < in.txt

echo "System equilibration"
# temperature equilibration
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
gmx mdrun -ntmpi $1 -ntomp $2 -nsteps $4 -deffnm nvt -gpu_id $3
echo "16 0" > in.txt
gmx energy -f nvt.edr -o temperature.xvg < in.txt

# pressure and density equilibration
gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
gmx mdrun -ntmpi $1 -ntomp $2 -nsteps $4 -deffnm npt -gpu_id $3
echo "18 0" > in.txt
gmx energy -f npt.edr -o pressure.xvg < in.txt
echo "24 0" > in.txt
gmx energy -f npt.edr -o density.xvg < in.txt

echo "Molecular dynamics production"
gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr
time gmx mdrun -ntmpi $1 -ntomp $2 -nsteps $4 -deffnm md_0_1 -gpu_id $3

rm in.txt
