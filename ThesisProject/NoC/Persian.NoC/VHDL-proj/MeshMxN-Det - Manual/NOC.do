onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider TopLevel
add wave -noupdate -format Logic -radix unsigned /noc_test/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/stop
add wave -noupdate -format Logic -radix unsigned /noc_test/stop2
add wave -noupdate -format Logic -radix unsigned /noc_test/reset
add wave -noupdate -format Literal -radix unsigned /noc_test/sentcnt
add wave -noupdate -format Literal -radix unsigned /noc_test/rececnt
add wave -noupdate -format Logic -radix unsigned /noc_test/stopsim
add wave -noupdate -divider computation
add wave -noupdate -format Logic -radix unsigned /noc_test/cm/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/cm/reset
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetimeall
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(15)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(14)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(13)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(12)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(11)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(10)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(9)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(8)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(7)
add wave -noupdate -color Red -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(6)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(5)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(4)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(3)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(2)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(1)
add wave -noupdate -format Analog-Step -height 50 -radix unsigned -scale 0.5 /noc_test/cm/averecetime(0)
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/cm/averecetime
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/cm/averecetimeall
add wave -noupdate -format Literal -radix unsigned /noc_test/cm/preaverecetimeall
add wave -noupdate -format Logic -radix unsigned /noc_test/cm/writefin3
add wave -noupdate -format Literal -radix unsigned /noc_test/cm/tdataavetime
add wave -noupdate -format Logic -radix unsigned /noc_test/cm/writeavetimerece
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(15)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(14)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(13)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(12)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(11)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(10)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(9)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(8)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(7)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(6)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(5)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(4)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(3)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(2)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(1)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(0)
add wave -noupdate -format Literal -radix unsigned /noc_test/cm/sentcnt
add wave -noupdate -format Literal -radix unsigned /noc_test/cm/rececnt
add wave -noupdate -format Logic -radix unsigned /noc_test/cm/clk
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(15)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(14)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(13)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(12)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(11)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(10)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(9)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(8)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(7)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(6)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(5)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(4)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(3)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(2)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(1)
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/rececnt(0)
add wave -noupdate -format Literal -radix unsigned /noc_test/cm/sentallcnt
add wave -noupdate -format Literal -radix unsigned /noc_test/cm/receallcnt
add wave -noupdate -format Analog-Step -height 100 -radix unsigned -scale 0.02 /noc_test/cm/sentallcnt
add wave -noupdate -color {Orange Red} -format Analog-Step -height 100 -offset 5000.0 -radix unsigned -scale 0.02 /noc_test/cm/receallcnt
add wave -noupdate -format Logic -radix unsigned /noc_test/cm/writefin1
add wave -noupdate -format Logic -radix unsigned /noc_test/cm/writefin2
add wave -noupdate -format Logic -radix unsigned /noc_test/cm/stop
add wave -noupdate -format Literal -radix unsigned /noc_test/cm/tdatasent
add wave -noupdate -format Literal -radix unsigned /noc_test/cm/tdatarece
add wave -noupdate -format Logic -radix unsigned /noc_test/cm/writesentcnt
add wave -noupdate -format Logic -radix unsigned /noc_test/cm/writerececnt
add wave -noupdate -format Literal -radix unsigned /noc_test/cm/presentallcnt
add wave -noupdate -format Literal -radix unsigned /noc_test/cm/prereceallcnt
add wave -noupdate -format Logic -radix unsigned /noc_test/cm/stopsim
add wave -noupdate -format Literal -radix unsigned /noc_test/cm/totalpacks
add wave -noupdate -divider meshMxN
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/reset
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/data
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/data2
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/en
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/en2
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/ready
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/ready2
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/sel
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/sel2
add wave -noupdate -divider Routers
add wave -noupdate -divider router0
add wave -noupdate -divider router1
add wave -noupdate -divider router2
add wave -noupdate -divider router3
add wave -noupdate -divider router4
add wave -noupdate -divider router5
add wave -noupdate -divider router6
add wave -noupdate -divider router7
add wave -noupdate -divider router8
add wave -noupdate -divider router9
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(10)
add wave -noupdate -divider router10
add wave -noupdate -divider router11
add wave -noupdate -divider router12
add wave -noupdate -divider router13
add wave -noupdate -divider router14
add wave -noupdate -format Literal -height 15 -radix unsigned /noc_test/cm/sentcnt(14)
add wave -noupdate -divider router15
add wave -noupdate -divider PEv0
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/reset
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/inpdata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/inpen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/inpready
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/inpsel
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__0/m1/n2/outpdata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/outpen
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__0/m1/n2/outpready
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__0/m1/n2/outpsel
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/sentcnt
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/rececnt
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__0/m1/n2/averecetimearr
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__0/m1/n2/sumtimedataarr
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__0/m1/n2/numberarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/averecetime
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/stopsim
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/outpdataarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/outpenarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/outpreadyarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/inpdataarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/inpenarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/inpreadyarr
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/stop
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/readfin
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/writefin
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/rececntarr
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__0/m1/n2/averecetimearr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/writefinarr
add wave -noupdate -divider ReaderV0
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/reset
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/outpdata
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/outpen
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/readfi
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/outpready
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/counter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/sentcnt
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/readfin
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/stop
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/datapoisson
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/datauniform
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/timesum
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/readfin1
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/readfin2
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/receiver
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/timecounter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/ltcounter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/data
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/outpenpoisson
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/outpenuniform
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/readf
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/prereadf
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/prereadfi
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/c1/firsttime
add wave -noupdate -divider ReaderV1
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/reset
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/outpdata
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/prereadfi
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/sentcnt
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/prereadf
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/outpen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/outpready
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/readfin
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/stop
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/datapoisson
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/datauniform
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/timesum
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/readfin1
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/readfin2
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/counter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/receiver
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/timecounter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/ltcounter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/data
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/rec
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/outpenpoisson
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/outpenuniform
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/readf
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/readfi
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__1/m1/n2/c1/firsttime
add wave -noupdate -divider ReaderV11
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/reset
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/outpdata
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/outpen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/outpready
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/sentcnt
add wave -noupdate -format Literal -expand /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/readfi
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/readfin
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/stop
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/datapoisson
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/datauniform
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/timesum
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/readfin1
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/readfin2
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/counter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/receiver
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/timecounter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/ltcounter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/data
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/rec
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/outpenpoisson
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/outpenuniform
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/readf
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/prereadf
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/prereadfi
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__2/mg2__3/m1/n2/c1/firsttime
add wave -noupdate -divider ReaderV14
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/inpfilepoisson
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/inpfileuniform
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/datawidth
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/vichaddr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/vich
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/packwidth
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/packgen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/packgennum
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/packsize
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/reset
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/outpdata
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/outpen
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/outpready
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/sentcnt
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/readfin
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/stop
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/datapoisson
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/datauniform
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/timesum
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/readfin1
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/readfin2
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/counter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/receiver
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/timecounter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/ltcounter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/data
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/rec
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/outpenpoisson
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/outpenuniform
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/readf
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/prereadf
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/readfi
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/prereadfi
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/firsttime
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/packcnt
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__3/mg2__2/m1/n2/c1/disablesend
add wave -noupdate -divider Reservator0
add wave -noupdate -divider Reservator1
add wave -noupdate -divider Reservator2
add wave -noupdate -divider Reservator5
add wave -noupdate -divider Reservator14
add wave -noupdate -divider switch0
add wave -noupdate -divider Switch1
add wave -noupdate -divider Switch2
add wave -noupdate -divider Switch3
add wave -noupdate -divider Switch9
add wave -noupdate -divider Addrext0-4
add wave -noupdate -divider Addrext1-0
add wave -noupdate -divider Addrext1-2-0
add wave -noupdate -divider AddrExt2-0-0
add wave -noupdate -divider AddrExt2-0-1
add wave -noupdate -divider AddrExt2-4-0
add wave -noupdate -divider AddrExt3-0
add wave -noupdate -divider Addrext9-0
add wave -noupdate -divider AddrExt14-8
add wave -noupdate -divider PE0-mux
add wave -noupdate -divider Mux1-0
add wave -noupdate -divider Demux1-0
add wave -noupdate -divider Demux0-2
add wave -noupdate -divider Demux1-4
add wave -noupdate -divider Addrext0-2-0
add wave -noupdate -divider Addrext1-4-0
add wave -noupdate -divider AddrExt1-2-1
add wave -noupdate -divider Addrext6-7
add wave -noupdate -divider switch6
add wave -noupdate -divider reservator6
add wave -noupdate -divider Writer0-0
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/outpfilepack
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/outpfiletime
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/datawidth
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/vichaddr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/vich
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/packwidth
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/packgen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/packgennum
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/packsize
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/reset
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/inpdata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/inpen
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/inpready
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/rececnt
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/averecetime
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/sumtimedata
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/number
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/writefin
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/stop
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/savedata
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/tdata
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/timedata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/writetime
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/writefin1
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/writefin2
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/inppackcounter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/timecounter
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/preinpen
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/packfinishedflag
add wave -noupdate -format Literal /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/outpfilepack
add wave -noupdate -format Literal /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/outpfiletime
add wave -noupdate -format Literal /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/datawidth
add wave -noupdate -format Literal /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/vichaddr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/vich
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/packwidth
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/packgen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/packgennum
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/packsize
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/reset
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/inpdata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/inpen
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/inpready
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/rececnt
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/averecetime
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/sumtimedata
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/number
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/writefin
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/stop
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/savedata
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/tdata
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/timedata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/writetime
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/writefin1
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/writefin2
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/inppackcounter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/timecounter
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/preinpen
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/packfinishedflag
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__1/m1/n2/mx2__1/c3/ignorenum
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__0/mg2__0/m1/n2/mx2__0/c3/ignorenum
add wave -noupdate -divider writer4-vi0
add wave -noupdate -format Literal /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/outpfilepack
add wave -noupdate -format Literal /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/outpfiletime
add wave -noupdate -format Literal /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/datawidth
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/vichaddr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/vich
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/packwidth
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/packgen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/packgennum
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/packsize
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/reset
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/inpdata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/inpen
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/inpready
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/rececnt
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/averecetime
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/sumtimedata
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/number
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/writefin
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/stop
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/timedata
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/savedata
add wave -noupdate -format Literal -radix unsigned -expand /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/tdata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/writetime
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/writefin1
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/writefin2
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/inppackcounter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/timecounter
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/preinpen
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/packfinishedflag
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/mx2__0/c3/ignorenum
add wave -noupdate -divider PEv4
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/inpfilepoisson
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/inpfileuniform
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/outpfilepack
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/outpfiletime
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/datawidth
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/vichaddr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/vich
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/packwidth
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/packgen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/packgennum
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/reset
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/inpdata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/inpen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/inpready
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/inpsel
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/outpdata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/outpen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/outpready
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/outpsel
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/sentcnt
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/rececnt
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/averecetime
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/stopsim
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/outpdataarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/outpenarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/outpreadyarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/inpdataarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/inpenarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/inpreadyarr
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/stop
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/readfin
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/writefin
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/rececntarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/averecetimearr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/sumtimedataarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/numberarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__0/m1/n2/writefinarr
add wave -noupdate -divider PEv6
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/inpfilepoisson
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/inpfileuniform
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/outpfilepack
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/outpfiletime
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/datawidth
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/vichaddr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/vich
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/curnode
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/packwidth
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/packgen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/packgennum
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/reset
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/inpdata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/inpen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/inpready
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/inpsel
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/outpdata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/outpen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/outpready
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/outpsel
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/sentcnt
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/rececnt
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/averecetime
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/stopsim
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/outpdataarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/outpenarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/outpreadyarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/inpdataarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/inpenarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/inpreadyarr
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/stop
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/readfin
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/writefin
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/rececntarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/averecetimearr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/sumtimedataarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/numberarr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/writefinarr
add wave -noupdate -divider Writer6-0
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/outpfilepack
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/outpfiletime
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/datawidth
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/vichaddr
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/vich
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/curnode
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/packwidth
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/packgen
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/packgennum
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/packsize
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/clk
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/reset
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/inpdata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/inpen
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/inpready
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/rececnt
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/averecetime
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/sumtimedata
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/number
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/writefin
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/stop
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/savedata
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/tdata
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/timedata
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/writetime
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/writefin1
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/writefin2
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/inppackcounter
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/timecounter
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/preinpen
add wave -noupdate -format Logic -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/packfinishedflag
add wave -noupdate -format Literal -radix unsigned /noc_test/c1/mg1__1/mg2__2/m1/n2/mx2__0/c3/ignorenum
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {62875 ns} 0} {{Cursor 2} {60740 ns} 0} {{Cursor 3} {71212 ns} 0} {{Cursor 4} {39345 ns} 0}
WaveRestoreZoom {0 ns} {23399 ns}
configure wave -namecolwidth 137
configure wave -valuecolwidth 66
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
