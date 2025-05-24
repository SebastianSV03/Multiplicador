`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.05.2023 15:32:57
// Design Name: 
// Module Name: datapath_multiplicador
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

//Este ejemplo fue dado por el profesor, no hay diseño en el cuaderno, solo en el documento de él
module datapath_multiplicador(
    input clk,
    input [7:0] P, //numero que se va a multiplicar
    input [7:0] Q, //numero por el que se va a multiplicar
    output reg [15:0] M,  // respuesta de la multiplicación
    input EM,
    input RA,
    input RRQ,
    input RRP,
    output reg [7:0] RQ
    );

    //reg  [15:0] M;
    wire [15:0] nextM;
    reg  [15:0] A;
    wire [15:0] nextA;
    //reg  [7:0] RQ;
    wire [7:0] nextRQ;
    reg  [15:0] RP;
    wire [15:0] nextRP;
    
    // Registro M
    always @(posedge clk)
        M <= nextM;
    // Parte combinacional de M
    assign nextM = (EM)?A:M;
    
    // Registro A
    always @(posedge clk)
        A <= nextA;
    // Parte combinacional de A
    assign nextA = (RA)? 16'd0 : A+( RP & {16{RQ[0]}} );
    // en la linea anterior se hace una suma aritmetica entre A y la multiplicacion del algebra de bool entre RP y RQ[0] de 16 bits
    
    // Registro RQ
    always @(posedge clk)
        RQ <= nextRQ;
    // Parte combinacional de RQ
    assign nextRQ = (RRQ)? Q : {1'b0, RQ[7:1]};
    //en la linea anterior se elimina el bit de menor peso
    //luego se mueven los bits restantes hacia la derecha (RQ[7:1])
    //se inserta un cero en el bit de mayor peso que quedó vacio por el desplazamiento 
    
    // Registro RP
    always @(posedge clk)
        RP <= nextRP;
    // Parte combinacional de RP
    assign nextRP = (RRP)? {8'b0, P} : {RP[14:0], 1'b0};
    //en la linea anterior si RRP es 1 entonces se hace un desplazamiento de los 8 bits de P hacia los valores de menor peso
    //luego se insertan 8 bits de ceros en los bits de mayor peso
    //si RRP es 0 entonces se elimina el bit de mayor peso y se hace un desplazamiento hacia la izquierda de los bits restantes
    //se inserta un cero en el bit de menor peso que queda vacio
endmodule
