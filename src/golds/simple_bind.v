module simple_bind_asserts(
  input I, O, CLK);

  wire _magma_inline_wire0;	// <stdin>:3:28
  wire _magma_inline_wire1;	// <stdin>:6:28

  assign _magma_inline_wire0 = O;	// <stdin>:4:5
  assign _magma_inline_wire1 = I;	// <stdin>:7:5
  assert property (@(posedge CLK) _magma_inline_wire1 |-> ##1 _magma_inline_wire0);	// <stdin>:5:10, :8:10, :9:5
endmodule

module simple_bind(
  input  I, CLK,
  output O);

  reg Register_inst0;	// <stdin>:13:23

  always @(posedge CLK)	// <stdin>:14:5
    Register_inst0 <= I;	// <stdin>:15:7
  initial	// <stdin>:17:5
    Register_inst0 = 1'h0;	// <stdin>:18:16, :19:7
  wire _T = Register_inst0;	// <stdin>:21:10
  // This instance is elsewhere emitted as a bind statement.
  // simple_bind_asserts simple_bind_asserts_inst (	// <stdin>:22:5
  //   .I   (I),
  //   .O   (_T),
  //   .CLK (CLK)
  // );
  assign O = _T;	// <stdin>:23:5
endmodule


// ----- 8< ----- FILE "bindfile" ----- 8< -----

bind simple_bind simple_bind_asserts simple_bind_asserts_inst (
  .I   (I),
  .O   (Register_inst0),
  .CLK (CLK)
);
