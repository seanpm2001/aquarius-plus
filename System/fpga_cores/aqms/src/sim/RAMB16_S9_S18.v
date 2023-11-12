// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/unisims/RAMB16_S9_S18.v,v 1.10 2007/02/22 01:58:06 wloo Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 10.1
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  16K-Bit Data and 2K-Bit Parity Dual Port Block RAM
// /___/   /\     Filename : RAMB16_S9_S18.v
// \   \  /  \    Timestamp : Thu Mar 10 16:44:01 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/10/05 - Initialized outputs.
//    02/21/07 - Fixed parameter SIM_COLLISION_CHECK (CR 433281).
// End Revision

`timescale 1 ps/1 ps

module RAMB16_S9_S18(
    input  wire        CLKA,
    input  wire        SSRA,
    input  wire [10:0] ADDRA,
    output wire  [7:0] DOA,
    output wire  [0:0] DOPA,
    input  wire  [7:0] DIA,
    input  wire  [0:0] DIPA,
    input  wire        ENA,
    input  wire        WEA,

    input  wire        CLKB,
    input  wire        SSRB,
    input  wire  [9:0] ADDRB,
    output wire [15:0] DOB,
    output wire  [1:0] DOPB,
    input  wire [15:0] DIB,
    input  wire  [1:0] DIPB,
    input  wire        ENB,
    input  wire        WEB);

    parameter INIT_A = 9'h0;
    parameter INIT_B = 18'h0;
    parameter SRVAL_A = 9'h0;
    parameter SRVAL_B = 18'h0;
    parameter WRITE_MODE_A = "WRITE_FIRST";
    parameter WRITE_MODE_B = "WRITE_FIRST";
    parameter SIM_COLLISION_CHECK = "ALL";
    localparam SETUP_ALL = 1000;
    localparam SETUP_READ_FIRST = 3000;

    parameter INIT_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_10 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_11 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_12 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_13 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_14 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_15 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_16 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_17 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_18 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_19 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_20 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_21 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_22 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_23 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_24 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_25 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_26 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_27 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_28 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_29 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_30 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_31 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_32 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_33 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_34 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_35 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_36 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_37 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_38 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_39 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;

    reg  [7:0] doa_out  = INIT_A[7:0];
    reg  [0:0] dopa_out = INIT_A[8:8];
    reg [15:0] dob_out  = INIT_B[15:0];
    reg  [1:0] dopb_out = INIT_B[17:16];
    
    reg [15:0] mem[1023:0];
    reg  [1:0] memp[1023:0];
    
    reg [8:0] count, countp;
    reg [1:0] wr_mode_a, wr_mode_b;

    reg [5:0] dmi, dbi;
    reg [5:0] pmi, pbi;

    wire [10:0] addra_int;
    reg  [10:0] addra_reg;
    wire  [7:0] dia_int;
    wire  [0:0] dipa_int;
    wire        ena_int, clka_int, wea_int, ssra_int;
    reg         ena_reg, wea_reg, ssra_reg;
    wire  [9:0] addrb_int;
    reg   [9:0] addrb_reg;
    wire [15:0] dib_int;
    wire  [1:0] dipb_int;
    wire        enb_int, clkb_int, web_int, ssrb_int;
    reg         display_flag, output_flag;
    reg         enb_reg, web_reg, ssrb_reg;

    time time_clka, time_clkb;
    time time_clka_clkb;
    time time_clkb_clka;

    reg setup_all_a_b;
    reg setup_all_b_a;
    reg setup_zero;
    reg setup_rf_a_b;
    reg setup_rf_b_a;
    reg [1:0] data_collision, data_collision_a_b, data_collision_b_a;
    reg memory_collision, memory_collision_a_b, memory_collision_b_a;
    reg change_clka;
    reg change_clkb;

    wire [14:0] data_addra_int;
    wire [14:0] data_addra_reg;
    wire [14:0] data_addrb_int;
    wire [14:0] data_addrb_reg;

    wire dia_enable = ena_int && wea_int;
    wire dib_enable = enb_int && web_int;

    tri0 GSR = 1'b0;    //glbl.GSR;
    wire gsr_int;

    buf b_gsr (gsr_int, GSR);

    buf b_doa [7:0] (DOA, doa_out);
    buf b_dopa [0:0] (DOPA, dopa_out);
    buf b_addra [10:0] (addra_int, ADDRA);
    buf b_dia [7:0] (dia_int, DIA);
    buf b_dipa [0:0] (dipa_int, DIPA);
    buf b_ena (ena_int, ENA);
    buf b_clka (clka_int, CLKA);
    buf b_ssra (ssra_int, SSRA);
    buf b_wea (wea_int, WEA);

    buf b_dob [15:0] (DOB, dob_out);
    buf b_dopb [1:0] (DOPB, dopb_out);
    buf b_addrb [9:0] (addrb_int, ADDRB);
    buf b_dib [15:0] (dib_int, DIB);
    buf b_dipb [1:0] (dipb_int, DIPB);
    buf b_enb (enb_int, ENB);
    buf b_clkb (clkb_int, CLKB);
    buf b_ssrb (ssrb_int, SSRB);
    buf b_web (web_int, WEB);

    
    always @(gsr_int)
        if (gsr_int) begin
            assign {dopa_out, doa_out} = INIT_A;
            assign {dopb_out, dob_out} = INIT_B;
        end else begin
            deassign doa_out;
            deassign dopa_out;
            deassign dob_out;
            deassign dopb_out;
        end

    
    initial begin
        for (count = 0; count < 16; count = count + 1) begin
            mem[count]           = INIT_00[(count * 16) +: 16];
            mem[16 * 1 + count]  = INIT_01[(count * 16) +: 16];
            mem[16 * 2 + count]  = INIT_02[(count * 16) +: 16];
            mem[16 * 3 + count]  = INIT_03[(count * 16) +: 16];
            mem[16 * 4 + count]  = INIT_04[(count * 16) +: 16];
            mem[16 * 5 + count]  = INIT_05[(count * 16) +: 16];
            mem[16 * 6 + count]  = INIT_06[(count * 16) +: 16];
            mem[16 * 7 + count]  = INIT_07[(count * 16) +: 16];
            mem[16 * 8 + count]  = INIT_08[(count * 16) +: 16];
            mem[16 * 9 + count]  = INIT_09[(count * 16) +: 16];
            mem[16 * 10 + count] = INIT_0A[(count * 16) +: 16];
            mem[16 * 11 + count] = INIT_0B[(count * 16) +: 16];
            mem[16 * 12 + count] = INIT_0C[(count * 16) +: 16];
            mem[16 * 13 + count] = INIT_0D[(count * 16) +: 16];
            mem[16 * 14 + count] = INIT_0E[(count * 16) +: 16];
            mem[16 * 15 + count] = INIT_0F[(count * 16) +: 16];
            mem[16 * 16 + count] = INIT_10[(count * 16) +: 16];
            mem[16 * 17 + count] = INIT_11[(count * 16) +: 16];
            mem[16 * 18 + count] = INIT_12[(count * 16) +: 16];
            mem[16 * 19 + count] = INIT_13[(count * 16) +: 16];
            mem[16 * 20 + count] = INIT_14[(count * 16) +: 16];
            mem[16 * 21 + count] = INIT_15[(count * 16) +: 16];
            mem[16 * 22 + count] = INIT_16[(count * 16) +: 16];
            mem[16 * 23 + count] = INIT_17[(count * 16) +: 16];
            mem[16 * 24 + count] = INIT_18[(count * 16) +: 16];
            mem[16 * 25 + count] = INIT_19[(count * 16) +: 16];
            mem[16 * 26 + count] = INIT_1A[(count * 16) +: 16];
            mem[16 * 27 + count] = INIT_1B[(count * 16) +: 16];
            mem[16 * 28 + count] = INIT_1C[(count * 16) +: 16];
            mem[16 * 29 + count] = INIT_1D[(count * 16) +: 16];
            mem[16 * 30 + count] = INIT_1E[(count * 16) +: 16];
            mem[16 * 31 + count] = INIT_1F[(count * 16) +: 16];
            mem[16 * 32 + count] = INIT_20[(count * 16) +: 16];
            mem[16 * 33 + count] = INIT_21[(count * 16) +: 16];
            mem[16 * 34 + count] = INIT_22[(count * 16) +: 16];
            mem[16 * 35 + count] = INIT_23[(count * 16) +: 16];
            mem[16 * 36 + count] = INIT_24[(count * 16) +: 16];
            mem[16 * 37 + count] = INIT_25[(count * 16) +: 16];
            mem[16 * 38 + count] = INIT_26[(count * 16) +: 16];
            mem[16 * 39 + count] = INIT_27[(count * 16) +: 16];
            mem[16 * 40 + count] = INIT_28[(count * 16) +: 16];
            mem[16 * 41 + count] = INIT_29[(count * 16) +: 16];
            mem[16 * 42 + count] = INIT_2A[(count * 16) +: 16];
            mem[16 * 43 + count] = INIT_2B[(count * 16) +: 16];
            mem[16 * 44 + count] = INIT_2C[(count * 16) +: 16];
            mem[16 * 45 + count] = INIT_2D[(count * 16) +: 16];
            mem[16 * 46 + count] = INIT_2E[(count * 16) +: 16];
            mem[16 * 47 + count] = INIT_2F[(count * 16) +: 16];
            mem[16 * 48 + count] = INIT_30[(count * 16) +: 16];
            mem[16 * 49 + count] = INIT_31[(count * 16) +: 16];
            mem[16 * 50 + count] = INIT_32[(count * 16) +: 16];
            mem[16 * 51 + count] = INIT_33[(count * 16) +: 16];
            mem[16 * 52 + count] = INIT_34[(count * 16) +: 16];
            mem[16 * 53 + count] = INIT_35[(count * 16) +: 16];
            mem[16 * 54 + count] = INIT_36[(count * 16) +: 16];
            mem[16 * 55 + count] = INIT_37[(count * 16) +: 16];
            mem[16 * 56 + count] = INIT_38[(count * 16) +: 16];
            mem[16 * 57 + count] = INIT_39[(count * 16) +: 16];
            mem[16 * 58 + count] = INIT_3A[(count * 16) +: 16];
            mem[16 * 59 + count] = INIT_3B[(count * 16) +: 16];
            mem[16 * 60 + count] = INIT_3C[(count * 16) +: 16];
            mem[16 * 61 + count] = INIT_3D[(count * 16) +: 16];
            mem[16 * 62 + count] = INIT_3E[(count * 16) +: 16];
            mem[16 * 63 + count] = INIT_3F[(count * 16) +: 16];
        end

        for (countp = 0; countp < 128; countp = countp + 1) begin
            memp[countp]           = INITP_00[(countp * 2) +: 2];
            memp[128 * 1 + countp] = INITP_01[(countp * 2) +: 2];
            memp[128 * 2 + countp] = INITP_02[(countp * 2) +: 2];
            memp[128 * 3 + countp] = INITP_03[(countp * 2) +: 2];
            memp[128 * 4 + countp] = INITP_04[(countp * 2) +: 2];
            memp[128 * 5 + countp] = INITP_05[(countp * 2) +: 2];
            memp[128 * 6 + countp] = INITP_06[(countp * 2) +: 2];
            memp[128 * 7 + countp] = INITP_07[(countp * 2) +: 2];
        end
    
        change_clka          <= 0;
        change_clkb          <= 0;
        data_collision       <= 0;
        data_collision_a_b   <= 0;
        data_collision_b_a   <= 0;
        memory_collision     <= 0;
        memory_collision_a_b <= 0;
        memory_collision_b_a <= 0;
        setup_all_a_b        <= 0;
        setup_all_b_a        <= 0;
        setup_zero           <= 0;
        setup_rf_a_b         <= 0;
        setup_rf_b_a         <= 0;
    end

    assign data_addra_int = addra_int * 8;
    assign data_addra_reg = addra_reg * 8;
    assign data_addrb_int = addrb_int * 16;
    assign data_addrb_reg = addrb_reg * 16;

    initial begin
        display_flag = 1;
        output_flag = 1;
    
        case (SIM_COLLISION_CHECK)
            "NONE": begin
                output_flag = 0;
                display_flag = 0;
            end

            "WARNING_ONLY":    output_flag = 0;
            "GENERATE_X_ONLY": display_flag = 0;
            "ALL": ;

            default: begin
                $display("Attribute Syntax Error : The Attribute SIM_COLLISION_CHECK on RAMB16_S9_S18 instance %m is set to %s.  Legal values for this attribute are ALL, NONE, WARNING_ONLY or GENERATE_X_ONLY.", SIM_COLLISION_CHECK);
                $finish;
            end
        endcase
    end

    always @(posedge clka_int) begin
        if ((output_flag || display_flag)) begin
            time_clka = $time;
            #0 time_clkb_clka = time_clka - time_clkb;
            change_clka = ~change_clka;
        end
    end
    
    always @(posedge clkb_int) begin
        if ((output_flag || display_flag)) begin
            time_clkb = $time;
            #0 time_clka_clkb = time_clkb - time_clka;
            change_clkb = ~change_clkb;
        end
    end
    
    always @(change_clkb) begin
        if ((0 < time_clka_clkb) && (time_clka_clkb < SETUP_ALL))
            setup_all_a_b = 1;
        if ((0 < time_clka_clkb) && (time_clka_clkb < SETUP_READ_FIRST))
            setup_rf_a_b = 1;
    end

    always @(change_clka) begin
        if ((0 < time_clkb_clka) && (time_clkb_clka < SETUP_ALL))
            setup_all_b_a = 1;
        if ((0 < time_clkb_clka) && (time_clkb_clka < SETUP_READ_FIRST))
            setup_rf_b_a = 1;
    end

    always @(change_clkb or change_clka) begin
        if ((time_clkb_clka == 0) && (time_clka_clkb == 0))
            setup_zero = 1;
    end

    always @(posedge setup_zero) begin
        if ((ena_int == 1) && (wea_int == 1) &&
            (enb_int == 1) && (web_int == 1) &&
            (data_addra_int[14:4] == data_addrb_int[14:4]))
            memory_collision <= 1;
    end

    always @(posedge setup_all_a_b or posedge setup_rf_a_b) begin
        if ((ena_reg == 1) && (wea_reg == 1) &&
            (enb_int == 1) && (web_int == 1) &&
            (data_addra_reg[14:4] == data_addrb_int[14:4]))
            memory_collision_a_b <= 1;
    end

    always @(posedge setup_all_b_a or posedge setup_rf_b_a) begin
        if ((ena_int == 1) && (wea_int == 1) &&
            (enb_reg == 1) && (web_reg == 1) &&
            (data_addra_int[14:4] == data_addrb_reg[14:4]))
            memory_collision_b_a <= 1;
    end

    always @(posedge setup_all_a_b) begin
        if (data_addra_reg[14:4] == data_addrb_int[14:4]) begin
            if ((ena_reg == 1) && (enb_int == 1)) begin
                case ({wr_mode_a, wr_mode_b, wea_reg, web_int})
                    6'b000011 : begin data_collision_a_b <= 2'b11; display_wa_wb; end
                    6'b000111 : begin data_collision_a_b <= 2'b11; display_wa_wb; end
                    6'b001011 : begin data_collision_a_b <= 2'b10; display_wa_wb; end
            //      6'b010011 : begin data_collision_a_b <= 2'b00; display_wa_wb; end
            //      6'b010111 : begin data_collision_a_b <= 2'b00; display_wa_wb; end
            //      6'b011011 : begin data_collision_a_b <= 2'b00; display_wa_wb; end
                    6'b100011 : begin data_collision_a_b <= 2'b01; display_wa_wb; end
                    6'b100111 : begin data_collision_a_b <= 2'b01; display_wa_wb; end
                    6'b101011 : begin display_wa_wb; end
                    6'b000001 : begin data_collision_a_b <= 2'b10; display_ra_wb; end
            //      6'b000101 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
                    6'b001001 : begin data_collision_a_b <= 2'b10; display_ra_wb; end
                    6'b010001 : begin data_collision_a_b <= 2'b10; display_ra_wb; end
            //      6'b010101 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
                    6'b011001 : begin data_collision_a_b <= 2'b10; display_ra_wb; end
                    6'b100001 : begin data_collision_a_b <= 2'b10; display_ra_wb; end
            //      6'b100101 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
                    6'b101001 : begin data_collision_a_b <= 2'b10; display_ra_wb; end
                    6'b000010 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
                    6'b000110 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
                    6'b001010 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
            //      6'b010010 : begin data_collision_a_b <= 2'b00; display_wa_rb; end
            //      6'b010110 : begin data_collision_a_b <= 2'b00; display_wa_rb; end
            //      6'b011010 : begin data_collision_a_b <= 2'b00; display_wa_rb; end
                    6'b100010 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
                    6'b100110 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
                    6'b101010 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
                endcase
            end
        end
        setup_all_a_b <= 0;
    end

    always @(posedge setup_all_b_a) begin
        if (data_addra_int[14:4] == data_addrb_reg[14:4]) begin
            if ((ena_int == 1) && (enb_reg == 1)) begin
                case ({wr_mode_a, wr_mode_b, wea_int, web_reg})
                    6'b000011 : begin data_collision_b_a <= 2'b11; display_wa_wb; end
            //      6'b000111 : begin data_collision_b_a <= 2'b00; display_wa_wb; end
                    6'b001011 : begin data_collision_b_a <= 2'b10; display_wa_wb; end
                    6'b010011 : begin data_collision_b_a <= 2'b11; display_wa_wb; end
            //      6'b010111 : begin data_collision_b_a <= 2'b00; display_wa_wb; end
                    6'b011011 : begin data_collision_b_a <= 2'b10; display_wa_wb; end
                    6'b100011 : begin data_collision_b_a <= 2'b01; display_wa_wb; end
                    6'b100111 : begin data_collision_b_a <= 2'b01; display_wa_wb; end
                    6'b101011 : begin display_wa_wb; end
                    6'b000001 : begin data_collision_b_a <= 2'b10; display_ra_wb; end
                    6'b000101 : begin data_collision_b_a <= 2'b10; display_ra_wb; end
                    6'b001001 : begin data_collision_b_a <= 2'b10; display_ra_wb; end
                    6'b010001 : begin data_collision_b_a <= 2'b10; display_ra_wb; end
                    6'b010101 : begin data_collision_b_a <= 2'b10; display_ra_wb; end
                    6'b011001 : begin data_collision_b_a <= 2'b10; display_ra_wb; end
                    6'b100001 : begin data_collision_b_a <= 2'b10; display_ra_wb; end
                    6'b100101 : begin data_collision_b_a <= 2'b10; display_ra_wb; end
                    6'b101001 : begin data_collision_b_a <= 2'b10; display_ra_wb; end
                    6'b000010 : begin data_collision_b_a <= 2'b01; display_wa_rb; end
                    6'b000110 : begin data_collision_b_a <= 2'b01; display_wa_rb; end
                    6'b001010 : begin data_collision_b_a <= 2'b01; display_wa_rb; end
            //      6'b010010 : begin data_collision_b_a <= 2'b00; display_wa_rb; end
            //      6'b010110 : begin data_collision_b_a <= 2'b00; display_wa_rb; end
            //      6'b011010 : begin data_collision_b_a <= 2'b00; display_wa_rb; end
                    6'b100010 : begin data_collision_b_a <= 2'b01; display_wa_rb; end
                    6'b100110 : begin data_collision_b_a <= 2'b01; display_wa_rb; end
                    6'b101010 : begin data_collision_b_a <= 2'b01; display_wa_rb; end
                endcase
            end
        end
        setup_all_b_a <= 0;
    end

    always @(posedge setup_zero) begin
        if (data_addra_int[14:4] == data_addrb_int[14:4]) begin
            if ((ena_int == 1) && (enb_int == 1)) begin
                case ({wr_mode_a, wr_mode_b, wea_int, web_int})
                    6'b000011 : begin data_collision <= 2'b11; display_wa_wb; end
                    6'b000111 : begin data_collision <= 2'b11; display_wa_wb; end
                    6'b001011 : begin data_collision <= 2'b10; display_wa_wb; end
                    6'b010011 : begin data_collision <= 2'b11; display_wa_wb; end
                    6'b010111 : begin data_collision <= 2'b11; display_wa_wb; end
                    6'b011011 : begin data_collision <= 2'b10; display_wa_wb; end
                    6'b100011 : begin data_collision <= 2'b01; display_wa_wb; end
                    6'b100111 : begin data_collision <= 2'b01; display_wa_wb; end
                    6'b101011 : begin display_wa_wb; end
                    6'b000001 : begin data_collision <= 2'b10; display_ra_wb; end
            //      6'b000101 : begin data_collision <= 2'b00; display_ra_wb; end
                    6'b001001 : begin data_collision <= 2'b10; display_ra_wb; end
                    6'b010001 : begin data_collision <= 2'b10; display_ra_wb; end
            //      6'b010101 : begin data_collision <= 2'b00; display_ra_wb; end
                    6'b011001 : begin data_collision <= 2'b10; display_ra_wb; end
                    6'b100001 : begin data_collision <= 2'b10; display_ra_wb; end
            //      6'b100101 : begin data_collision <= 2'b00; display_ra_wb; end
                    6'b101001 : begin data_collision <= 2'b10; display_ra_wb; end
                    6'b000010 : begin data_collision <= 2'b01; display_wa_rb; end
                    6'b000110 : begin data_collision <= 2'b01; display_wa_rb; end
                    6'b001010 : begin data_collision <= 2'b01; display_wa_rb; end
            //      6'b010010 : begin data_collision <= 2'b00; display_wa_rb; end
            //      6'b010110 : begin data_collision <= 2'b00; display_wa_rb; end
            //      6'b011010 : begin data_collision <= 2'b00; display_wa_rb; end
                    6'b100010 : begin data_collision <= 2'b01; display_wa_rb; end
                    6'b100110 : begin data_collision <= 2'b01; display_wa_rb; end
                    6'b101010 : begin data_collision <= 2'b01; display_wa_rb; end
                endcase
            end
        end
        setup_zero <= 0;
    end

    task display_ra_wb;
    begin
        if (display_flag)
            $display("Memory Collision Error on RAMB16_S9_S18:%m at simulation time %.3f ns\nA read was performed on address %h (hex) of Port A while a write was requested to the same address on Port B. The write will be successful however the read value on Port A is unknown until the next CLKA cycle.", $time/1000.0, addra_int);
        end
    endtask

    task display_wa_rb;
    begin
        if (display_flag)
            $display("Memory Collision Error on RAMB16_S9_S18:%m at simulation time %.3f ns\nA read was performed on address %h (hex) of Port B while a write was requested to the same address on Port A. The write will be successful however the read value on Port B is unknown until the next CLKB cycle.", $time/1000.0, addrb_int);
        end
    endtask

    task display_wa_wb;
    begin
        if (display_flag)
            $display("Memory Collision Error on RAMB16_S9_S18:%m at simulation time %.3f ns\nA write was requested to the same address simultaneously at both Port A and Port B of the RAM. The contents written to the RAM at address location %h (hex) of Port A and address location %h (hex) of Port B are unknown.", $time/1000.0, addra_int, addrb_int);
        end
    endtask

    always @(posedge setup_rf_a_b) begin
        if (data_addra_reg[14:4] == data_addrb_int[14:4]) begin
            if ((ena_reg == 1) && (enb_int == 1)) begin
                case ({wr_mode_a, wr_mode_b, wea_reg, web_int})
            //      6'b000011 : begin data_collision_a_b <= 2'b00; display_wa_wb; end
            //      6'b000111 : begin data_collision_a_b <= 2'b00; display_wa_wb; end
            //      6'b001011 : begin data_collision_a_b <= 2'b00; display_wa_wb; end
                    6'b010011 : begin data_collision_a_b <= 2'b11; display_wa_wb; end
                    6'b010111 : begin data_collision_a_b <= 2'b11; display_wa_wb; end
                    6'b011011 : begin data_collision_a_b <= 2'b10; display_wa_wb; end
            //      6'b100011 : begin data_collision_a_b <= 2'b00; display_wa_wb; end
            //      6'b100111 : begin data_collision_a_b <= 2'b00; display_wa_wb; end
            //      6'b101011 : begin data_collision_a_b <= 2'b00; display_wa_wb; end
            //      6'b000001 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
            //      6'b000101 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
            //      6'b001001 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
            //      6'b010001 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
            //      6'b010101 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
            //      6'b011001 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
            //      6'b100001 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
            //      6'b100101 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
            //      6'b101001 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
            //      6'b000010 : begin data_collision_a_b <= 2'b00; display_wa_rb; end
            //      6'b000110 : begin data_collision_a_b <= 2'b00; display_wa_rb; end
            //      6'b001010 : begin data_collision_a_b <= 2'b00; display_wa_rb; end
                    6'b010010 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
                    6'b010110 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
                    6'b011010 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
            //      6'b100010 : begin data_collision_a_b <= 2'b00; display_wa_rb; end
            //      6'b100110 : begin data_collision_a_b <= 2'b00; display_wa_rb; end
            //      6'b101010 : begin data_collision_a_b <= 2'b00; display_wa_rb; end
                endcase
            end
        end
        setup_rf_a_b <= 0;
    end

    always @(posedge setup_rf_b_a) begin
        if (data_addra_int[14:4] == data_addrb_reg[14:4]) begin
            if ((ena_int == 1) && (enb_reg == 1)) begin
                case ({wr_mode_a, wr_mode_b, wea_int, web_reg})
            //      6'b000011 : begin data_collision_b_a <= 2'b00; display_wa_wb; end
                    6'b000111 : begin data_collision_b_a <= 2'b11; display_wa_wb; end
            //      6'b001011 : begin data_collision_b_a <= 2'b00; display_wa_wb; end
            //      6'b010011 : begin data_collision_b_a <= 2'b00; display_wa_wb; end
                    6'b010111 : begin data_collision_b_a <= 2'b11; display_wa_wb; end
            //      6'b011011 : begin data_collision_b_a <= 2'b00; display_wa_wb; end
            //      6'b100011 : begin data_collision_b_a <= 2'b00; display_wa_wb; end
                    6'b100111 : begin data_collision_b_a <= 2'b01; display_wa_wb; end
            //      6'b101011 : begin data_collision_b_a <= 2'b00; display_wa_wb; end
            //      6'b000001 : begin data_collision_b_a <= 2'b00; display_ra_wb; end
                    6'b000101 : begin data_collision_b_a <= 2'b10; display_ra_wb; end
            //      6'b001001 : begin data_collision_b_a <= 2'b00; display_ra_wb; end
            //      6'b010001 : begin data_collision_b_a <= 2'b00; display_ra_wb; end
                    6'b010101 : begin data_collision_b_a <= 2'b10; display_ra_wb; end
            //      6'b011001 : begin data_collision_b_a <= 2'b00; display_ra_wb; end
            //      6'b100001 : begin data_collision_b_a <= 2'b00; display_ra_wb; end
                    6'b100101 : begin data_collision_b_a <= 2'b10; display_ra_wb; end
            //      6'b101001 : begin data_collision_b_a <= 2'b00; display_ra_wb; end
            //      6'b000010 : begin data_collision_b_a <= 2'b00; display_wa_rb; end
            //      6'b000110 : begin data_collision_b_a <= 2'b00; display_wa_rb; end
            //      6'b001010 : begin data_collision_b_a <= 2'b00; display_wa_rb; end
            //      6'b010010 : begin data_collision_b_a <= 2'b00; display_wa_rb; end
            //      6'b010110 : begin data_collision_b_a <= 2'b00; display_wa_rb; end
            //      6'b011010 : begin data_collision_b_a <= 2'b00; display_wa_rb; end
            //      6'b100010 : begin data_collision_b_a <= 2'b00; display_wa_rb; end
            //      6'b100110 : begin data_collision_b_a <= 2'b00; display_wa_rb; end
            //      6'b101010 : begin data_collision_b_a <= 2'b00; display_wa_rb; end
                endcase
            end
        end
        setup_rf_b_a <= 0;
    end

    always @(posedge clka_int) begin
        if ((output_flag || display_flag)) begin
            addra_reg <= addra_int;
            ena_reg <= ena_int;
            ssra_reg <= ssra_int;
            wea_reg <= wea_int;
        end
    end
    
    always @(posedge clkb_int) begin
        if ((output_flag || display_flag)) begin
            addrb_reg <= addrb_int;
            enb_reg <= enb_int;
            ssrb_reg <= ssrb_int;
            web_reg <= web_int;
        end
    end
    
    // Data
    always @(posedge memory_collision) begin
        if ((output_flag || display_flag)) begin
            mem[addra_int[10:1]][addra_int[0:0] * 8 +: 8] <= 8'bx;
            memory_collision <= 0;
        end
    end

    always @(posedge memory_collision_a_b) begin
        if ((output_flag || display_flag)) begin
            mem[addra_reg[10:1]][addra_reg[0:0] * 8 +: 8] <= 8'bx;
            memory_collision_a_b <= 0;
        end
    end
    
    always @(posedge memory_collision_b_a) begin
        if ((output_flag || display_flag)) begin
            mem[addra_int[10:1]][addra_int[0:0] * 8 +: 8] <= 8'bx;
            memory_collision_b_a <= 0;
        end
    end
    
    always @(posedge data_collision[1]) begin
        if (ssra_int == 0 && output_flag) begin
            doa_out <= #100 8'bX;
        end
        data_collision[1] <= 0;
    end

    always @(posedge data_collision[0]) begin
        if (ssrb_int == 0 && output_flag) begin
            dob_out[addra_int[0:0] * 8 +: 8] <= #100 8'bX;
        end
        data_collision[0] <= 0;
    end

    always @(posedge data_collision_a_b[1]) begin
        if (ssra_reg == 0 && output_flag) begin
            doa_out <= #100 8'bX;
        end
        data_collision_a_b[1] <= 0;
    end

    always @(posedge data_collision_a_b[0]) begin
        if (ssrb_int == 0 && output_flag) begin
            dob_out[addra_reg[0:0] * 8 +: 8] <= #100 8'bX;
        end
        data_collision_a_b[0] <= 0;
    end

    always @(posedge data_collision_b_a[1]) begin
        if (ssra_int == 0 && output_flag) begin
            doa_out <= #100 8'bX;
        end
        data_collision_b_a[1] <= 0;
    end

    always @(posedge data_collision_b_a[0]) begin
        if (ssrb_reg == 0 && output_flag) begin
            dob_out[addra_int[0:0] * 8 +: 8] <= #100 8'bX;
        end
        data_collision_b_a[0] <= 0;
    end

    // x parity start
    always @(posedge memory_collision) begin
        if ((output_flag || display_flag))
            memp[addra_int[10:1]][addra_int[0:0] * 1 +: 1] <= 1'bx;
    end

    always @(posedge memory_collision_a_b) begin
        if ((output_flag || display_flag))
            memp[addra_reg[10:1]][addra_reg[0:0] * 1 +: 1] <= 1'bx;
    end

    always @(posedge memory_collision_b_a) begin
        if ((output_flag || display_flag))
            memp[addra_int[10:1]][addra_int[0:0] * 1 +: 1] <= 1'bx;
    end
    
    always @(posedge data_collision[1]) begin
        if (ssra_int == 0 && output_flag) begin
            dopa_out <= #100 1'bX;
        end
    end

    always @(posedge data_collision_a_b[1]) begin
        if (ssra_reg == 0 && output_flag) begin
            dopa_out <= #100 1'bX;
        end
    end
    
    always @(posedge data_collision_b_a[1]) begin
        if (ssra_int == 0 && output_flag) begin
            dopa_out <= #100 1'bX;
        end
    end

    always @(posedge data_collision[0]) begin
        if (ssrb_int == 0 && output_flag) begin
            dopb_out[addra_int[0:0] +: 1] <= #100 1'bx;
        end
    end

    always @(posedge data_collision_a_b[0]) begin
        if (ssrb_int == 0 && output_flag) begin
            dopb_out[addra_reg[0:0] +: 1] <= #100 1'bx;
        end
    end

    always @(posedge data_collision_b_a[0]) begin
        if (ssrb_reg == 0 && output_flag) begin
            dopb_out[addra_int[0:0] +: 1] <= #100 1'bx;
        end
    end
    // x parity end

    initial begin
        case (WRITE_MODE_A)
            "WRITE_FIRST": wr_mode_a <= 2'b00;
            "READ_FIRST":  wr_mode_a <= 2'b01;
            "NO_CHANGE":   wr_mode_a <= 2'b10;
            default: begin
                $display("Attribute Syntax Error : The Attribute WRITE_MODE_A on RAMB16_S9_S18 instance %m is set to %s.  Legal values for this attribute are WRITE_FIRST, READ_FIRST or NO_CHANGE.", WRITE_MODE_A);
                $finish;
            end
        endcase
    end

    initial begin
        case (WRITE_MODE_B)
            "WRITE_FIRST": wr_mode_b <= 2'b00;
            "READ_FIRST":  wr_mode_b <= 2'b01;
            "NO_CHANGE":   wr_mode_b <= 2'b10;
            default: begin
                $display("Attribute Syntax Error : The Attribute WRITE_MODE_B on RAMB16_S9_S18 instance %m is set to %s.  Legal values for this attribute are WRITE_FIRST, READ_FIRST or NO_CHANGE.", WRITE_MODE_B);
                $finish;
            end
        endcase
    end

    // Port A
    always @(posedge clka_int) begin
        if (ena_int == 1'b1) begin
            if (ssra_int == 1'b1) begin
                {dopa_out, doa_out} <= #100 SRVAL_A;
            end else begin
                if (wea_int == 1'b1) begin
                    if (wr_mode_a == 2'b00) begin
                        doa_out <= #100 dia_int;
                        dopa_out <= #100 dipa_int;
                    end else if (wr_mode_a == 2'b01) begin
                        doa_out <= #100 mem[addra_int[10:1]][addra_int[0:0] * 8 +: 8];
                        dopa_out <= #100 memp[addra_int[10:1]][addra_int[0:0] * 1 +: 1];
                    end
                end else begin
                    doa_out <= #100 mem[addra_int[10:1]][addra_int[0:0] * 8 +: 8];
                    dopa_out <= #100 memp[addra_int[10:1]][addra_int[0:0] * 1 +: 1];
                end
            end

            // memory
            if (wea_int == 1'b1) begin
                mem[addra_int[10:1]][addra_int[0:0] * 8 +: 8] <= dia_int;
                memp[addra_int[10:1]][addra_int[0:0] * 1 +: 1] <= dipa_int;
            end
        end
    end

    // Port B
    always @(posedge clkb_int) begin
        if (enb_int == 1'b1) begin
            if (ssrb_int == 1'b1) begin
                {dopb_out, dob_out} <= #100 SRVAL_B;
            end else begin
                if (web_int == 1'b1) begin
                    if (wr_mode_b == 2'b00) begin
                        dob_out <= #100 dib_int;
                        dopb_out <= #100 dipb_int;
                    end else if (wr_mode_b == 2'b01) begin
                        dob_out <= #100 mem[addrb_int];
                        dopb_out <= #100 memp[addrb_int];
                    end
                end else begin
                    dob_out <= #100 mem[addrb_int];
                    dopb_out <= #100 memp[addrb_int];
                end
            end

            // memory
            if (web_int == 1'b1) begin
                mem[addrb_int] <= dib_int;
                memp[addrb_int] <= dipb_int;
            end
        end
    end

endmodule
