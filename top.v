//TOP.v
module TOP(CLK, RST, EN, EN_A, STRING);
input CLK, RST, EN, EN_A;
//input CLK, RST, EN;
input [7:0] STRING;

//GOTO_ADDR.v
wire [11:0] ADDR_G;

//GOTO_RAM.v
wire [7:0] CURRENT_STATE_G, NEXT_STATE;//G=GOTO_FUNCTION
wire [3:0] CHARA;

//FAILURE_ADDR.v
wire [11:0] ADDR_F;

//FAILURE_RAM.v
wire [7:0] CURRENT_STATE_F, FAILURE_STATE;//F=FAILURE_FUNCITON

//TABLE_READER.v
//TABLE_READER1.v
wire [7:0] NOW_STATE_A;
wire [7:0] NOW_STATE_IN;
wire [7:0] NOW_STATE_OUT;
wire EX_NEXT;

GOTO_RAM GOTO_RAM(
    .CLK(CLK),
    .RST(RST), 
    .ADDR_G(ADDR_G),
    .CURRENT_STATE_G(CURRENT_STATE_G),
    .CHARA(CHARA),
    .NEXT_STATE(NEXT_STATE)
);

GOTO_ADDR GOTO_ADDR(
    .CLK(CLK),
    .RST(RST),
    .ADDR_G(ADDR_G)
);

FAILURE_RAM FAILURE_RAM(
    .CLK(CLK),
    .RST(RST), 
    .ADDR_F(ADDR_F),
    .CURRENT_STATE_F(CURRENT_STATE_F),
    .FAILURE_STATE(FAILURE_STATE)
);

FAILURE_ADDR FAILURE_ADDR(
    .CLK(CLK),
    .RST(RST),
    .ADDR_F(ADDR_F)
);

TABLE_READER TABLE_READER(
  .CLK(CLK),
  .RST(RST),
  .EN(EN),
  .STRING(STRING),
  .NOW_STATE(NOW_STATE_A)
);

TABLE_READER1 TABLE_READER1(
  .CLK(CLK),
  .RST(RST),
  .EN(EN_A),
  .STRING(STRING),
  .NOW_STATE_IN(NOW_STATE_A),
  .NOW_STATE_OUT(NOW_STATE_OUT),
  .EN_MATCH(EN_MATCH)
);

REGISTER REGISTER(
  .CLK(CLK),
  .RST(RST),
  .EN(EN),
  .EN1(EN_A),
  .NOW_STATE(NOW_STATE_A),
  .NOW_STATE1(NOW_STATE_OUT)
);

MATCH MATCH(
  .CLK(CLK),
  .RST(RST),
  .EN(EN_MATCH),
  .STATE_DATA(NOW_STATE_OUT),
  .MATCH(MATCH)
);

endmodule
