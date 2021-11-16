module complex_bind_asserts(
  input I, O, CLK, I0);

  wire _magma_inline_wire0;	// <stdin>:3:28
  wire _magma_inline_wire1;	// <stdin>:6:28
  wire _magma_inline_wire2;	// <stdin>:9:28

  assign _magma_inline_wire0 = O;	// <stdin>:4:5
  assign _magma_inline_wire1 = I;	// <stdin>:7:5
  assign _magma_inline_wire2 = I0;	// <stdin>:10:5
  assert property (@(posedge CLK) _magma_inline_wire1 |-> ##1 _magma_inline_wire0);assert property (_magma_inline_wire1 |-> _magma_inline_wire2;	// <stdin>:5:10, :8:10, :11:10, :12:5
endmodule

module complex_bind(
  input  I, CLK,
  output O);

  wire complex_bind_asserts_inst_I0;	// <stdin>:27:5
  reg  Register_inst0;	// <stdin>:18:23

  always @(posedge CLK)	// <stdin>:19:5
    Register_inst0 <= I;	// <stdin>:20:7
  initial	// <stdin>:22:5
    Register_inst0 = 1'h0;	// <stdin>:23:16, :24:7
  wire _T = Register_inst0;	// <stdin>:26:10
  assign complex_bind_asserts_inst_I0 = ~I;	// <stdin>:17:10, :27:5
  // This instance is elsewhere emitted as a bind statement.
  // complex_bind_asserts complex_bind_asserts_inst (	// <stdin>:27:5
  //   .I   (I),
  //   .O   (_T),
  //   .CLK (CLK),
  //   .I0  (complex_bind_asserts_inst_I0)	// <stdin>:27:5
  // );
  assign O = _T;	// <stdin>:28:5
endmodule


// ----- 8< ----- FILE "bindfile" ----- 8< -----

bind complex_bind complex_bind_asserts complex_bind_asserts_inst (
  .I   (I),
  .O   (Register_inst0),
  .CLK (CLK),
  .I0  (complex_bind_asserts_inst_I0)
);
