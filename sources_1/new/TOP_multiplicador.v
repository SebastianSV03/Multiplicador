`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2023 12:44:20
// Design Name: 
// Module Name: TOP_multiplicador
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TOP_multiplicador(
    // se describen las entradas y salidas del diseño en general
    input clk,
    input start,
    output busy,
    input [7:0] P,
    input [7:0] Q,
    output [15:0] M
    );
    // se ingresan cables para conectar las entradas y salidas de cada una de las cajas creadas y conectarlas con el TOP
    wire EM, RA, RRQ, RRP;
    wire [7:0] RQ;
    
    datapath_multiplicador Datapath (
        .clk(clk),
        .P(P),
        .Q(Q),
        .M(M),
        .EM(EM),
        .RA(RA),
        .RRQ(RRQ),
        .RRP(RRP),
        .RQ(RQ)
        );
        
     FSM_multiplicador Control_Unit (
            .clk(clk),
            .start(start),
            .RQ(RQ),
            .EM(EM),
            .RA(RA),
            .RRQ(RRQ),
            .RRP(RRP),
            .busy(busy)
            );
endmodule
