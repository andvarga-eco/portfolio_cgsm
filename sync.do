clear
set more off

cd"C:\Users\andre\Google Drive\Uninorte\AE-CGSM-Redes\Paper portfolio\paper\Plos_sub"
use sync.dta,clear

reshape wide capturakg rmincome cpue incpue, i(year mes) j(especie) 
foreach var of varlist capturakg* rmincome* incpue* cpue*{
replace `var'=0 if `var'==.
}

egen totc=rowtotal(capturakg1 capturakg2 capturakg3 capturakg4 capturakg5 capturakg6 capturakg7)
egen totcpue=rowtotal(cpue1 cpue2 cpue3 cpue4 cpue5 cpue6 cpue7 cpue8)
egen totrinc=rowtotal(rmincome1 rmincome2 rmincome3 rmincome4 rmincome5 rmincome6 rmincome7 rmincome8)
egen totincpue=rowtotal(incpue1 incpue2 incpue3 incpue4 incpue5 incpue6 incpue7 incpue8)
 
*phi statistic
quietly summ totc
gen vartot=r(Var)
forvalue i=1(1)8{
quietly summ capturakg`i'
gen var`i'=r(Var)
gen sd`i'=r(sd)
}
egen sumvar=rowtotal(var1-var8)
egen sumsd=rowtotal(sd1 sd2 sd3 sd4 sd5 sd6 sd7 sd8)
gen totcov=(vartot-sumvar)/2
gen phin=vartot/sumsd^2

quietly summ totrinc
gen vartotinc=r(Var)
forvalue i=1(1)8{
quietly summ rmincome`i'
gen varinc`i'=r(Var)
gen sdinc`i'=r(sd)
}
egen sumvarinc=rowtotal(varinc1-varinc8)
egen sumsdinc=rowtotal(sdinc1 sdinc2 sdinc3 sdinc4 sdinc5 sdinc6 sdinc7 sdinc8)
gen totcovinc=(vartotinc-sumvarinc)/2
gen phininc=vartotinc/sumsdinc^2


quietly summ totcpue
gen vartotcpue=r(Var)
forvalue i=1(1)8{
quietly summ cpue`i'
gen varcpue`i'=r(Var)
gen sdcpue`i'=r(sd)
}
egen sumvarcpue=rowtotal(varcpue1-varcpue8)
egen sumsdcpue=rowtotal(sdcpue1 sdcpue2 sdcpue3 sdcpue4 sdcpue5 sdcpue6 sdcpue7 sdcpue8)
gen totcovcpue=(vartotcpue-sumvarcpue)/2
gen phincpue=vartotcpue/sumsdcpue^2

quietly summ totincpue
gen vartotincpue=r(Var)
forvalue i=1(1)8{
quietly summ incpue`i'
gen varincpue`i'=r(Var)
gen sdincpue`i'=r(sd)
}
egen sumvarincpue=rowtotal(varincpue1-varincpue8)
egen sumsdincpue=rowtotal(sdincpue1 sdincpue2 sdincpue3 sdincpue4 sdincpue5 sdincpue6 sdincpue7 sdincpue8)
gen totcovincpue=(vartotincpue-sumvarincpue)/2
gen phinincpue=vartotincpue/sumsdincpue^2

summ phin*
