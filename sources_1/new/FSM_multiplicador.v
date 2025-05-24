`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2023 12:34:44
// Design Name: 
// Module Name: FSM_multiplicador
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


module FSM_multiplicador(
    input clk,
    input start,
    input [7:0] RQ,
    output reg EM,
    output reg RA,
    output reg RRQ,
    output reg RRP,
    output reg busy
    );
    //a continuación de define la codificación para los estados del FSM
    parameter Espera  = 2'b00;
    parameter Calcula = 2'b01;
    parameter Imprime = 2'b10;
    
    reg [1:0] presente = Espera; // Registro de Estado - Valor inicial
    reg [1:0] futuro;            // Entrada del registro de Estado

    // Registro de estado 
    always @(posedge clk)
        presente <= futuro;

    // Lógica del estado siguiente
    always @(presente, start, RQ) //se ingresan las entradas de la logica del estado siguiente
        case (presente) // segun lo que sea actualmente presente se dan las condiciones para cambiar a otro estado
            Espera : // si presente es actualmete "Espera"
                if(start)
                    futuro <= Calcula;
                else
                    futuro <= Espera;
            Calcula: // si presente es actualmente "Calcula"
                if(RQ[7:1]==7'b0000000)
                    futuro <= Imprime;
                else
                    futuro <= Calcula;
            Imprime: // si presente es actualmente "Imprime"
                futuro <= Espera;
            default:
                futuro <= Espera;
        endcase
    
    // Lógica de salida
    always @(presente) // la entrada de la logica de salida es presente
        case (presente) // se describen los valores para las salidad del FSM segun presente se encuentre em algun estado
            Espera : begin // si presente es "Espera"
                EM <= 1'b0;
                RA <= 1'b1;
                RRQ <= 1'b1;
                RRP <= 1'b1;
                busy <= 1'b0;
            end
            Calcula: begin // si presente es "Calcula"
                EM <= 1'b0;
                RA <= 1'b0;
                RRQ <= 1'b0;
                RRP <= 1'b0;
                busy <= 1'b1;
            end
            Imprime: begin  // si presente es "imprime"
                EM <= 1'b1;
                RA <= 1'b1;
                RRQ <= 1'b1;
                RRP <= 1'b1;
                busy <= 1'b1;
            end
            default: begin  // estado seguro para en caso de algun error inesperado va al estado "Espera"
                EM <= 1'b0;
                RA <= 1'b1;
                RRQ <= 1'b1;
                RRP <= 1'b1;
                busy <= 1'b0;
            end
        endcase
endmodule
