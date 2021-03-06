hw.module @BasicALU(%a: i4, %b: i4, %opcode: i4) -> (out: i4) {
    %0 = comb.icmp eq %a, %b : i4
    %1 = hw.constant 0 : i1
    %2 = hw.constant 0 : i1
    %3 = hw.constant 0 : i1
    %4 = comb.concat %3, %2, %1, %0 : i1, i1, i1, i1
    %5 = comb.icmp ult %a, %b : i4
    %6 = hw.constant 0 : i1
    %7 = hw.constant 0 : i1
    %8 = hw.constant 0 : i1
    %9 = comb.concat %8, %7, %6, %5 : i1, i1, i1, i1
    %10 = hw.constant 8 : i4
    %11 = comb.icmp eq %opcode, %10 : i4
    %13 = hw.array_create %4, %9 : i4
    %12 = hw.array_get %13[%11] : !hw.array<2xi4>
    %14 = comb.sub %a, %b : i4
    %15 = hw.constant 7 : i4
    %16 = comb.icmp eq %opcode, %15 : i4
    %18 = hw.array_create %12, %14 : i4
    %17 = hw.array_get %18[%16] : !hw.array<2xi4>
    %19 = comb.add %a, %b : i4
    %20 = hw.constant 6 : i4
    %21 = comb.icmp eq %opcode, %20 : i4
    %23 = hw.array_create %17, %19 : i4
    %22 = hw.array_get %23[%21] : !hw.array<2xi4>
    %24 = hw.constant 4 : i4
    %25 = comb.sub %a, %24 : i4
    %26 = hw.constant 5 : i4
    %27 = comb.icmp eq %opcode, %26 : i4
    %29 = hw.array_create %22, %25 : i4
    %28 = hw.array_get %29[%27] : !hw.array<2xi4>
    %30 = hw.constant 4 : i4
    %31 = comb.add %a, %30 : i4
    %32 = hw.constant 4 : i4
    %33 = comb.icmp eq %opcode, %32 : i4
    %35 = hw.array_create %28, %31 : i4
    %34 = hw.array_get %35[%33] : !hw.array<2xi4>
    %36 = hw.constant 1 : i4
    %37 = comb.sub %a, %36 : i4
    %38 = hw.constant 3 : i4
    %39 = comb.icmp eq %opcode, %38 : i4
    %41 = hw.array_create %34, %37 : i4
    %40 = hw.array_get %41[%39] : !hw.array<2xi4>
    %42 = hw.constant 1 : i4
    %43 = comb.add %a, %42 : i4
    %44 = hw.constant 2 : i4
    %45 = comb.icmp eq %opcode, %44 : i4
    %47 = hw.array_create %40, %43 : i4
    %46 = hw.array_get %47[%45] : !hw.array<2xi4>
    %48 = hw.constant 1 : i4
    %49 = comb.icmp eq %opcode, %48 : i4
    %51 = hw.array_create %46, %b : i4
    %50 = hw.array_get %51[%49] : !hw.array<2xi4>
    %52 = hw.constant 0 : i4
    %53 = comb.icmp eq %opcode, %52 : i4
    %55 = hw.array_create %50, %a : i4
    %54 = hw.array_get %55[%53] : !hw.array<2xi4>
    hw.output %54 : i4
}
