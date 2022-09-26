module Top(
    input                   sys_clk         ,
    input                   sys_rst_n       , 
    input           [31:0]  data_in1        ,
    input           [31:0]  data_in2        ,
    input           [1:0]   opcode          ,
    input                   trig            ,

    output          [31:0]  data_out        ,
    output                  vld             ,
    output                  work            
);


// Plus signal
wire            [31:0]      alu_data1           ;
wire            [31:0]      alu_data2           ;
wire            [31:0]      plus_result         ;
wire                        op_plus             ;
wire                        plus_trig           ;
wire                        plus_vld            ;

// Multi signal
wire            [31:0]      multi_result        ;
wire            [31:0]      multi_unit_data1    ;
wire            [31:0]      multi_unit_data2    ;
wire                        multi_trig          ;
wire                        multi_vld           ;

// Div signal
wire            [31:0]      div_result          ;
wire            [31:0]      div_unit_data1      ;
wire            [31:0]      div_unit_data2      ;
wire                        div_trig            ;
wire                        div_vld             ;

// Multi Unit signal
wire            [31:0]      unit_data1          ;
wire            [31:0]      unit_data2          ;
wire            [31:0]      unit_result         ;
wire                        unit_trig           ;
wire                        unit_vld            ;

// Universal multiplier select signal
wire                        multi_unit_sel      ;

assign  unit_data1  =   (multi_unit_sel) ? div_unit_data1   :   multi_unit_data1;
assign  unit_data2  =   (multi_unit_sel) ? div_unit_data2   :   multi_unit_data2;
assign  unit_trig   =   (multi_unit_sel) ? div_unit_trig    :   multi_unit_trig;  

Ctrl Ctrl_inst(
    // system signal
    .sys_clk                (sys_clk                ),  // i 1b
    .sys_rst_n              (sys_rst_n              ),  // i 1b
    // dataflow
    .data1_in               (data1_in               ),  // i 32b
    .data2_in               (data2_in               ),  // i 32b
    .plus_result_in         (plus_result            ),  // i 32b
    .multi_result_in        (multi_result           ),  // i 32b
    .div_result_in          (div_result             ),  // i 32b
    .data1_out              (alu_data1              ),  // o 32b
    .data2_out              (alu_data2              ),  // o 32b
    .result_out             (data_out               ),  // o 32b
    // control
    .opcode                 (opcode                 ),  // i 2b
    .trig                   (trig                   ),  // i 1b
    .plus_vld_in            (plus_vld               ),  // i 1b
    .multi_vld_in           (multi_vld              ),  // i 1b
    .div_vld_in             (div_vld                ),  // i 1b
    .multi_unit_sel         (multi_unit_sel         ),  // o 1b
    .sel_plus               (plus_trig              ),  // o 1b
    .sel_multi              (mult_trig              ),  // o 1b
    .sel_div                (div_trig               ),  // o 1b
    .op_plus                (op_plus                ),  // o 1b
    .work                   (work                   ),  // o 1b
    .result_vld             (vld                    )   // o 1b
);

Plus Plus_inst(
    // system signal
    .sys_clk                (sys_clk                ),  // i 1b
    .sys_rst_n              (sys_rst_n              ),  // i 1b
    // dataflow
    .data1_in               (alu_data1              ),  // i 32b
    .data2_in               (alu_data2              ),  // i 32b
    .data_out               (plus_result            ),  // o 32b
    // control
    .op                     (op_plus                ),  // i 1b
    .trig                   (plus_trig              ),  // i 1b
    .vld                    (plus_vld               )   // o 1b
);

Multi Multi_inst(
    // system signal                            
    .sys_clk                (sys_clk                ),  // i 1b
    .sys_rst_n              (sys_rst_n              ),  // i 1b
    // dataflow                                 
    .data1_in               (alu_data1              ),  // i 32b
    .data2_in               (alu_data2              ),  // i 32b
    .data_out               (multi_result           ),  // o 32b
    // control                                  
    .trig                   (multi_trig             ),  // i 1b
    .vld                    (multi_vld              ),  // o 1b
    // MultiUnit control                        
    .mul_result_in          (unit_result            ),  // i 32b
    .mul_data1_out          (multi_unit_data1       ),  // o 32b
    .mul_data2_out          (multi_unit_data2       ),  // o 32b
    // MultiUnit control
    .mul_result_vld         (unit_vld               ),  // i 1b
    .mul_trig_out           (multi_unit_trig        )   // o 1b
);

Div Div_inst(
    // system signal                            
    .sys_clk                (sys_clk                ),  // i 1b
    .sys_rst_n              (sys_rst_n              ),  // i 1b
    // dataflow                                 
    .data1_in               (alu_data1              ),  // i 32b
    .data2_in               (alu_data2              ),  // i 32b
    .data_out               (multi_result           ),  // o 32b
    // control                                  
    .trig                   (multi_trig             ),  // i 1b
    .vld                    (multi_vld              ),  // o 1b
    // MultiUnit control                        
    .mul_result_in          (unit_result            ),  // i 32b
    .mul_data1_out          (div_unit_data1         ),  // o 32b
    .mul_data2_out          (div_unit_data2         ),  // o 32b
    // MultiUnit control
    .mul_result_vld         (unit_vld               ),  // i 1b
    .mul_trig_out           (div_unit_trig          )   // o 1b
);

MultiUnit MultiUnit_inst(
    .sys_clk                (sys_clk                ),  // i 1b
    .sys_rst_n              (sys_rst_n              ),  // i 1b
    // dataflow
    .data1_in               (unit_data1             ),  // i 32b
    .data2_in               (unit_data2             ),  // i 32b
    .data_out               (unit_result            ),  // o 32b
    // control
    .trig                   (unit_trig              ),  // i 1b
    .vld                    (unit_vld               )   // o 1b
);


endmodule
