`timescale 1ns / 1ps

module tb_i2c_master;

    reg clk;
    reg rst_n;
    reg enable;
    reg rw;
    reg [6:0] slave_addr;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire busy;
    wire ack_error;
    wire scl;
    wire sda;

    // Emulated slave pull-down:
    // Whenever the master releases SDA (sda_oe == 0) while busy, the slave pulls SDA LOW to ACK.
    wire slave_ack = (busy && !uut.sda_oe) ? 1'b0 : 1'bz;
    assign sda = slave_ack;

    // Pull-up resistor for I2C lines
    pullup(sda);

    // Instantiate UUT
    i2c_master #(.CLK_DIV(4)) uut (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .rw(rw),
        .slave_addr(slave_addr),
        .data_in(data_in),
        .data_out(data_out),
        .busy(busy),
        .ack_error(ack_error),
        .scl(scl),
        .sda(sda)
    );

    // 50 MHz clock generation (20 ns period)
    always #10 clk = ~clk;

    initial begin
        clk        = 0;
        rst_n      = 0;
        enable     = 0;
        rw         = 0;
        slave_addr = 7'h50; // 0x50
        data_in    = 8'hA5; // 0xA5

        #100;
        rst_n = 1;
        #100;

        $display("[%0t ns] Starting I2C Write...", $time);
        enable = 1;
        #20;
        enable = 0;

        // Wait until transaction completes
        @(negedge busy);
        #200;
        $display("[%0t ns] Transaction Complete. Error flag: %b", $time, ack_error);

        #500;
        $finish;
    end

endmodule