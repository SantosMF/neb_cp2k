#!/usr/bin/bash
export NUMBER_OF_ATOMS=6
echo 'run reaction pathway'
./cp2k.ssmp -i neb.inp #-o neb.out
echo 'clean tmp_files'
rm *.wfn* *.restart*
for i in `ls SN2-pos-Replica*`; do tail -n $(($NUMBER_OF_ATOMS+2)) "$i" >> path.xyz ; done
awk '/E =/ {i=i+1; printf "%s %16.8f\n", i, $6}' path.xyz >> energy.dat
rm SN2* 
echo 'job done'
