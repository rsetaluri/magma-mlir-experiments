hw.module @simple_aggregates_tuple(%a: !hw.struct<x: i8, y: i8>) -> (%y: !hw.struct<x: i8, y: i8>) {
    %0 = hw.constant -1 : i8
    %1 = hw.constant -1 : i8
    %2 = hw.struct_extract %a["x"] : !hw.struct<x: i8, y: i8>
    %3 = hw.struct_extract %a["y"] : !hw.struct<x: i8, y: i8>
    %4 = comb.xor %2, %0 : i8
    %5 = comb.xor %3, %1 : i8
    %6 = hw.struct_create (%4, %5) : !hw.struct<x: i8, y: i8>
    hw.output %6 : !hw.struct<x: i8, y: i8>
}