clear
set more off


use "\sur.dta",clear

*zi: catch per unit of aggregate effort
*esfuerzo: aggregate effort (trips per month)
*salinidad: salinity

gen zi=capturakg/esfuerzo
keep year mes especie esfuerzo zi salinidad
reshape wide zi, i(year mes) j(especie)
sort year mes

gen sal2=salinidad^2

*NOTE: Other i=7, Megalops i=8. In the paper, table 3, Other i=8, Megalops i=7

* Replace missing to cero
forvalues j=1(1)8{
replace zi`j'=0 if zi`j'==. & zi2 !=.
}

*sureg MODEL
sort year mes
gen date=ym(year,mes)
format date %tm
tsset date
sort date
sureg (zi1 l.zi1 l.esfuerzo salinidad sal2 i.mes)(zi2 l.zi2 l.esfuerzo salinidad i.mes)(zi3 l.zi3 l.esfuerzo salinidad sal2 i.mes)(zi4 l.zi4 l.esfuerzo salinidad sal2 i.mes)(zi5 l.zi5 l.esfuerzo salinidad i.mes)(zi6 l.zi6 l.esfuerzo salinidad i.mes)(zi7 l.zi7 l.esfuerzo salinidad i.mes)(zi8 l.zi8 l.esfuerzo salinidad i.mes),corr
