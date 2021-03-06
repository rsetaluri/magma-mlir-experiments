hw.module @HiLoMultiplier(%A: i16, %B: i16) -> (Hi: i16, Lo: i16) {
    %0 = comb.extract %A from 0 : (i16) -> i1
    %1 = comb.extract %A from 1 : (i16) -> i1
    %2 = comb.extract %A from 2 : (i16) -> i1
    %3 = comb.extract %A from 3 : (i16) -> i1
    %4 = comb.extract %A from 4 : (i16) -> i1
    %5 = comb.extract %A from 5 : (i16) -> i1
    %6 = comb.extract %A from 6 : (i16) -> i1
    %7 = comb.extract %A from 7 : (i16) -> i1
    %8 = comb.extract %A from 8 : (i16) -> i1
    %9 = comb.extract %A from 9 : (i16) -> i1
    %10 = comb.extract %A from 10 : (i16) -> i1
    %11 = comb.extract %A from 11 : (i16) -> i1
    %12 = comb.extract %A from 12 : (i16) -> i1
    %13 = comb.extract %A from 13 : (i16) -> i1
    %14 = comb.extract %A from 14 : (i16) -> i1
    %15 = comb.extract %A from 15 : (i16) -> i1
    %16 = hw.constant 0 : i1
    %17 = hw.constant 0 : i1
    %18 = hw.constant 0 : i1
    %19 = hw.constant 0 : i1
    %20 = hw.constant 0 : i1
    %21 = hw.constant 0 : i1
    %22 = hw.constant 0 : i1
    %23 = hw.constant 0 : i1
    %24 = hw.constant 0 : i1
    %25 = hw.constant 0 : i1
    %26 = hw.constant 0 : i1
    %27 = hw.constant 0 : i1
    %28 = hw.constant 0 : i1
    %29 = hw.constant 0 : i1
    %30 = hw.constant 0 : i1
    %31 = hw.constant 0 : i1
    %32 = comb.concat %31, %30, %29, %28, %27, %26, %25, %24, %23, %22, %21, %20, %19, %18, %17, %16, %15, %14, %13, %12, %11, %10, %9, %8, %7, %6, %5, %4, %3, %2, %1, %0 : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
    %33 = comb.extract %B from 0 : (i16) -> i1
    %34 = comb.extract %B from 1 : (i16) -> i1
    %35 = comb.extract %B from 2 : (i16) -> i1
    %36 = comb.extract %B from 3 : (i16) -> i1
    %37 = comb.extract %B from 4 : (i16) -> i1
    %38 = comb.extract %B from 5 : (i16) -> i1
    %39 = comb.extract %B from 6 : (i16) -> i1
    %40 = comb.extract %B from 7 : (i16) -> i1
    %41 = comb.extract %B from 8 : (i16) -> i1
    %42 = comb.extract %B from 9 : (i16) -> i1
    %43 = comb.extract %B from 10 : (i16) -> i1
    %44 = comb.extract %B from 11 : (i16) -> i1
    %45 = comb.extract %B from 12 : (i16) -> i1
    %46 = comb.extract %B from 13 : (i16) -> i1
    %47 = comb.extract %B from 14 : (i16) -> i1
    %48 = comb.extract %B from 15 : (i16) -> i1
    %49 = hw.constant 0 : i1
    %50 = hw.constant 0 : i1
    %51 = hw.constant 0 : i1
    %52 = hw.constant 0 : i1
    %53 = hw.constant 0 : i1
    %54 = hw.constant 0 : i1
    %55 = hw.constant 0 : i1
    %56 = hw.constant 0 : i1
    %57 = hw.constant 0 : i1
    %58 = hw.constant 0 : i1
    %59 = hw.constant 0 : i1
    %60 = hw.constant 0 : i1
    %61 = hw.constant 0 : i1
    %62 = hw.constant 0 : i1
    %63 = hw.constant 0 : i1
    %64 = hw.constant 0 : i1
    %65 = comb.concat %64, %63, %62, %61, %60, %59, %58, %57, %56, %55, %54, %53, %52, %51, %50, %49, %48, %47, %46, %45, %44, %43, %42, %41, %40, %39, %38, %37, %36, %35, %34, %33 : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
    %66 = comb.mul %32, %65 : i32
    %67 = comb.extract %66 from 16 : (i32) -> i1
    %68 = comb.extract %66 from 17 : (i32) -> i1
    %69 = comb.extract %66 from 18 : (i32) -> i1
    %70 = comb.extract %66 from 19 : (i32) -> i1
    %71 = comb.extract %66 from 20 : (i32) -> i1
    %72 = comb.extract %66 from 21 : (i32) -> i1
    %73 = comb.extract %66 from 22 : (i32) -> i1
    %74 = comb.extract %66 from 23 : (i32) -> i1
    %75 = comb.extract %66 from 24 : (i32) -> i1
    %76 = comb.extract %66 from 25 : (i32) -> i1
    %77 = comb.extract %66 from 26 : (i32) -> i1
    %78 = comb.extract %66 from 27 : (i32) -> i1
    %79 = comb.extract %66 from 28 : (i32) -> i1
    %80 = comb.extract %66 from 29 : (i32) -> i1
    %81 = comb.extract %66 from 30 : (i32) -> i1
    %82 = comb.extract %66 from 31 : (i32) -> i1
    %83 = comb.concat %82, %81, %80, %79, %78, %77, %76, %75, %74, %73, %72, %71, %70, %69, %68, %67 : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
    %84 = comb.extract %66 from 0 : (i32) -> i1
    %85 = comb.extract %66 from 1 : (i32) -> i1
    %86 = comb.extract %66 from 2 : (i32) -> i1
    %87 = comb.extract %66 from 3 : (i32) -> i1
    %88 = comb.extract %66 from 4 : (i32) -> i1
    %89 = comb.extract %66 from 5 : (i32) -> i1
    %90 = comb.extract %66 from 6 : (i32) -> i1
    %91 = comb.extract %66 from 7 : (i32) -> i1
    %92 = comb.extract %66 from 8 : (i32) -> i1
    %93 = comb.extract %66 from 9 : (i32) -> i1
    %94 = comb.extract %66 from 10 : (i32) -> i1
    %95 = comb.extract %66 from 11 : (i32) -> i1
    %96 = comb.extract %66 from 12 : (i32) -> i1
    %97 = comb.extract %66 from 13 : (i32) -> i1
    %98 = comb.extract %66 from 14 : (i32) -> i1
    %99 = comb.extract %66 from 15 : (i32) -> i1
    %100 = comb.concat %99, %98, %97, %96, %95, %94, %93, %92, %91, %90, %89, %88, %87, %86, %85, %84 : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
    hw.output %83, %100 : i16, i16
}
