onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /axi_tb_top/axi_if_inst/aresetn
add wave -noupdate /axi_tb_top/axi_if_inst/awid
add wave -noupdate /axi_tb_top/axi_if_inst/awaddr
add wave -noupdate /axi_tb_top/axi_if_inst/awlen
add wave -noupdate /axi_tb_top/axi_if_inst/awsize
add wave -noupdate /axi_tb_top/axi_if_inst/awburst
add wave -noupdate /axi_tb_top/axi_if_inst/awvalid
add wave -noupdate /axi_tb_top/axi_if_inst/awready
add wave -noupdate /axi_tb_top/axi_if_inst/wid
add wave -noupdate /axi_tb_top/axi_if_inst/wdata
add wave -noupdate /axi_tb_top/axi_if_inst/wstrb
add wave -noupdate /axi_tb_top/axi_if_inst/wlast
add wave -noupdate /axi_tb_top/axi_if_inst/wvalid
add wave -noupdate /axi_tb_top/axi_if_inst/wready
add wave -noupdate /axi_tb_top/axi_if_inst/bid
add wave -noupdate /axi_tb_top/axi_if_inst/bresp
add wave -noupdate /axi_tb_top/axi_if_inst/bvalid
add wave -noupdate /axi_tb_top/axi_if_inst/bready
add wave -noupdate /axi_tb_top/axi_if_inst/arid
add wave -noupdate /axi_tb_top/axi_if_inst/araddr
add wave -noupdate /axi_tb_top/axi_if_inst/arlen
add wave -noupdate /axi_tb_top/axi_if_inst/arsize
add wave -noupdate /axi_tb_top/axi_if_inst/arburst
add wave -noupdate /axi_tb_top/axi_if_inst/aclk
add wave -noupdate /axi_tb_top/axi_if_inst/arvalid
add wave -noupdate /axi_tb_top/axi_if_inst/arready
add wave -noupdate /axi_tb_top/axi_if_inst/rid
add wave -noupdate /axi_tb_top/axi_if_inst/rdata
add wave -noupdate /axi_tb_top/axi_if_inst/rlast
add wave -noupdate /axi_tb_top/axi_if_inst/rvalid
add wave -noupdate /axi_tb_top/axi_if_inst/rready
add wave -noupdate /axi_tb_top/axi_if_inst/rresp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {34842 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 241
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {203243 ps} {317930 ps}
