set_fml_appmode FPV

set design axi4_lite_top

read_file -top axi4_lite_top -format sverilog -sva -vcs {-f ../Design/filelist +define+INLINE_SVA}

create_clock clk -period 100
create_reset rstn -sense low

sim_run -stable
sim_save_reset

fvassume -expr {@(posedge clk) $onehot({wr_en,rd_en})}
fvassume -expr {@(posedge clk) (!$isunknown(Read_Address))}
fvassume -expr {@(posedge clk) (!$isunknown(Write_Address))}
fvassume -expr {@(posedge clk) (!$isunknown(Write_Data))}
fvassume -expr {@(posedge clk) ($countbits(bfm.AWADDR) == 32)}
fvassume -expr {@(posedge clk) ($countbits(bfm.WDATA) == 32)}
fvassume -expr {@(posedge clk) ($countbits(bfm.RDATA) == 32)}

fvcover -expr {bfm.AWVALID inside {0,1}}
fvcover -expr {bfm.AWREADY inside {0,1}}
fvcover -expr {bfm.WVALID inside {0,1}}
fvcover -expr {bfm.WREADY inside {0,1}}
fvcover -expr {bfm.BREADY inside {0,1}}
fvcover -expr {bfm.BVALID inside {0,1}}
fvcover -expr {bfm.ARVALID inside {0,1}}
fvcover -expr {bfm.ARREADY inside {0,1}}
fvcover -expr {bfm.RVALID inside {0,1}}
fvcover -expr {bfm.RREADY inside {0,1}}
fvcover -expr {rd_en == 1}
fvcover -expr {wr_en == 1}

## assertion1
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.AWVALID && !bfm.AWREADY) |=> $stable(bfm.AWADDR) && bfm.AWVALID} 
## assertion2
fvassert -expr {@(posedge clk) disable iff(!rstn) (!bfm.AWREADY) |-> (!bfm.AWREADY) until (bfm.AWVALID)}
## assertion3
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.AWVALID |-> !$isunknown(bfm.AWADDR))}
## assertion4
fvassert -expr {@(posedge clk) ($rose(rstn)) |-> !bfm.AWVALID [*1]}
## assertion5
fvassert -expr {@(posedge clk) disable iff(!rstn) bfm.AWVALID |-> (bfm.AWVALID) until_with (bfm.AWREADY)}
## assertion6
fvassert -expr {@(posedge clk) disable iff(!rstn) bfm.AWVALID |-> s_eventually (bfm.AWREADY)}
## assertion7
fvassert -expr {@(posedge clk) (!$isunknown(bfm.AWVALID) throughout rstn)}
## assertion8
fvassert -expr {@(posedge clk) (!$isunknown(bfm.AWREADY) throughout rstn)}
## assertion9
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.AWVALID |-> !$isunknown(bfm.AWADDR))}
## assertion10
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.AWVALID && bfm.AWREADY) |=> !bfm.AWVALID}



## assertion11
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.WVALID && (!bfm.WREADY)) |=>  $stable(bfm.WDATA) && bfm.WVALID}
## assertion12
fvassert -expr {@(posedge clk) disable iff(!rstn) (!bfm.WREADY) |-> (!bfm.WREADY) until (bfm.WVALID)}
## assertion13
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.WVALID) |-> !$isunknown(bfm.WDATA)}
## assertion14
fvassert -expr {@(posedge clk) ($rose(rstn)) |-> !bfm.WVALID [*1]}
## assertion15
fvassert -expr {@(posedge clk) disable iff(!rstn) bfm.WVALID |-> (bfm.WVALID) until_with (bfm.WREADY)}
## assertion16
fvassert -expr {@(posedge clk) disable iff(!rstn) bfm.WVALID |-> s_eventually (bfm.WREADY)}
## assertion17
fvassert -expr {@(posedge clk) (!$isunknown(bfm.WVALID) throughout rstn)}
## assertion18
fvassert -expr {@(posedge clk) (!$isunknown(bfm.WREADY) throughout rstn)}
## assertion19
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.WVALID |-> !$isunknown(bfm.WDATA))}
## assertion20
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.WVALID && bfm.WREADY) |=> !bfm.WVALID}



## assertion21
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.AWVALID && !bfm.AWREADY) |=> !bfm.BVALID until bfm.AWREADY}
## assertion22
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.WVALID && bfm.WREADY) |=> (bfm.BVALID && bfm.BREADY)}
## assertion23
fvassert -expr {@(posedge clk) ($rose(rstn)) |-> !bfm.WVALID [*1]}
## assertion24
fvassert -expr {@(posedge clk) disable iff(!rstn) (!$isunknown(bfm.BVALID) throughout rstn)} 
## assertion25
fvassert -expr {@(posedge clk) disable iff(!rstn) (!$isunknown(bfm.BREADY) throughout rstn)}
## assertion26
fvassert -expr {@(posedge clk) disable iff(!rstn) bfm.BVALID |-> s_eventually (bfm.BREADY)}
## assertion27
fvassert -expr {@(posedge clk) disable iff(!rstn) bfm.BVALID |-> (bfm.BVALID) until_with (bfm.BREADY)}



## assertion28
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.ARVALID) && (!bfm.ARREADY) |=> $stable(bfm.ARADDR) && (bfm.ARVALID)}
## assertion29
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.ARVALID) |-> !$isunknown(bfm.ARADDR)}
## assertion30
fvassert -expr {@(posedge clk) $rose(rstn) |-> !bfm.ARVALID [*1]}
## assertion31
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.ARVALID) |-> (bfm.ARVALID) until_with (bfm.ARREADY)}
## assertion32
fvassert -expr {@(posedge clk) disable iff(!rstn) (!$isunknown(bfm.ARVALID) throughout rstn)}
## assertion33
fvassert -expr {@(posedge clk) disable iff(!rstn) (!$isunknown(bfm.ARREADY) throughout rstn)}
## assertion34
fvassert -expr {@(posedge clk) disable iff(!rstn) bfm.ARVALID |-> s_eventually (bfm.ARREADY)}
## assertion35
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.ARVALID && bfm.ARREADY) |=> !bfm.ARVALID}



## assertion36
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.RVALID) && (!bfm.RREADY) |=> $stable(bfm.RDATA) && (bfm.RVALID)}
## assertion37
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.RVALID) |-> !$isunknown(bfm.RDATA)}
## assertion38
fvassert -expr {@(posedge clk) $rose(rstn) |-> !bfm.RVALID [*1]}
## assertion39
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.RVALID) |-> (bfm.RVALID) until_with (bfm.RREADY)}
## assertion40
fvassert -expr {@(posedge clk) disable iff(!rstn) (!$isunknown(bfm.RVALID) throughout rstn)} 
## assertion41
fvassert -expr {@(posedge clk) disable iff(!rstn) (!$isunknown(bfm.RREADY) throughout rstn)}
## assertion42
fvassert -expr {@(posedge clk) disable iff(!rstn) bfm.RVALID |-> s_eventually (bfm.RREADY)}
## assertion43
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.RVALID && bfm.RREADY) |=> !bfm.RVALID}



## assertion44
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.AWVALID && bfm.AWREADY) |-> ##[1:$] (bfm.WVALID && bfm.WREADY)}
## assertion45
fvassert -expr {@(posedge clk) disable iff(!rstn) (bfm.ARVALID && bfm.ARREADY) |-> ##[1:$] (bfm.RVALID && bfm.RREADY)}
## assertion46
fvassert -expr {@(posedge clk) disable iff(!rstn) (!bfm.ARREADY) |-> (!bfm.ARREADY) until (bfm.ARVALID)}
## assertion47
fvassert -expr {@(posedge clk) disable iff(!rstn) (!bfm.AWREADY) |-> (!bfm.AWREADY) until (bfm.AWVALID)}
## assertion48
fvassert -expr {@(posedge clk) disable iff(!rstn) (!bfm.WREADY) |-> (!bfm.WREADY) until (bfm.WVALID)}
## assertion49
fvassert -expr {@(posedge clk) disable iff(!rstn) (!bfm.BVALID) |-> (!bfm.BVALID) until_with (bfm.AWREADY)}
## assertion50
fvassert -expr {@(posedge clk) disable iff(!rstn) (!bfm.BVALID) |-> (!bfm.BVALID) until_with (bfm.WREADY)}
## assertion51
fvassert -expr {@(posedge clk) disable iff(!rstn) (!bfm.WREADY) |-> (!bfm.WREADY) until ((bfm.WVALID) && (bfm.AWVALID))}