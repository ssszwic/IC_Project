module Top(
    input                   sys_clk         ,
    input                   sys_rst_n       , 
    input           [31:0]  data1_in        ,
    input           [31:0]  data2_in        ,
    input           [1:0]   opcode          ,
    input                   trig            ,

    output          [31:0]  data_out        ,
    output                  vld             ,
    output                  work            
);

// Ctrl signal
wire            [31:0]      alu_data1           ;
wire            [31:0]      alu_data2           ;

// Plus signal
wire            [31:0]      plus_result         ;
wire                        op_plus             ;
wire                        plus_trig           ;
wire                        plus_vld            ;

// Multi signal
wire            [31:0]      multi_result        ;
wire            [23:0]      multi_unit_data1    ;
wire            [23:0]      multi_unit_data2    ;
wire                        multi_unit_trig     ;
wire                        multi_trig          ;
wire                        multi_vld           ;

// Div signal
wire            [31:0]      div_result          ;
wire            [23:0]      div_unit_data1      ;
wire            [23:0]      div_unit_data2      ;
wire                        div_unit_trig       ;
wire                        div_trig            ;
wire                        div_vld             ;

// Multi Unit signal
wire            [22:0]      unit_result         ;
wire            [1:0]       unit_other          ;
wire                        unit_trig           ;
wire                        unit_vld            ;

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
    .sel_plus               (plus_trig              ),  // o 1b
    .sel_multi              (multi_trig              ),  // o 1b
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
    // cordic unit data flow                       
    .cordic_result_in       (unit_result            ),  // i 23b
    .cordic_other_in        (unit_other             ),  // i 2b
    .cordic_data1_out       (multi_unit_data1       ),  // o 24b
    .cordic_data2_out       (multi_unit_data2       ),  // o 24b
    // MultiUnit control
    .cordic_result_vld      (unit_vld               ),  // i 1b
    .cordic_trig_out        (multi_unit_trig        )   // o 1b
);


Div Div_inst(
    // system signal                            
    .sys_clk                (sys_clk                ),  // i 1b
    .sys_rst_n              (sys_rst_n              ),  // i 1b
    // dataflow                                 
    .data1_in               (alu_data1              ),  // i 32b
    .data2_in               (alu_data2              ),  // i 32b
    .data_out               (div_result             ),  // o 32b
    // control                                  
    .trig                   (div_trig               ),  // i 1b
    .vld                    (div_vld                ),  // o 1b
    // cordic unit data flow                       
    .cordic_result_in       (unit_result            ),  // i 23b
    .cordic_other_in        (unit_other             ),  // i 2b
    .cordic_data1_out       (div_unit_data1         ),  // o 24b
    .cordic_data2_out       (div_unit_data2         ),  // o 24b
    // MultiUnit control
    .cordic_result_vld      (unit_vld               ),  // i 1b
    .cordic_trig_out        (div_unit_trig          )   // o 1b
);


CordicUnit CordicUnit_inst(
    // system signal
    .sys_clk                (sys_clk                ),  // i 1b
    .sys_rst_n              (sys_rst_n              ),  // i 1b
    // data flow
    .mul_data1_in           (multi_unit_data1       ),  // i 24b
    .mul_data2_in           (multi_unit_data2       ),  // i 24b
    .div_data1_in           (div_unit_data1         ),  // i 24b
    .div_data2_in           (div_unit_data2         ),  // i 24b
    .data_out               (unit_result            ),  // o 23b
    .data_other             (unit_other             ),  // o 2b
    // control
    .mul_trig               (multi_unit_trig        ),  // i 1b
    .div_trig               (div_unit_trig          ),  // i 1b
    .vld                    (unit_vld               )   // o 1b
);

endmodule
