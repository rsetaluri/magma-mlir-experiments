hw.module @LUT(%I: i8) -> (%O: i8) {
    %0 = hw.instance "coreir_lut77194726158210796949047323339125271902179989777093709359638389338608753093290_inst0" @coreir_lut77194726158210796949047323339125271902179989777093709359638389338608753093290(%I) : (i8) -> (i1)
    %1 = hw.instance "coreir_lut92633671389852956338856788006950326282615987732512451231566067206330503711948_inst0" @coreir_lut92633671389852956338856788006950326282615987732512451231566067206330503711948(%I) : (i8) -> (i1)
    %2 = hw.instance "coreir_lut108980789870415242751596221184647442685430573802955824978313020242741769072880_inst0" @coreir_lut108980789870415242751596221184647442685430573802955824978313020242741769072880(%I) : (i8) -> (i1)
    %3 = hw.instance "coreir_lut115341536360906404779899502576747487978354537254490211650198994186870666100480_inst0" @coreir_lut115341536360906404779899502576747487978354537254490211650198994186870666100480(%I) : (i8) -> (i1)
    %4 = hw.instance "coreir_lut115790322417210952336529717160220497262186272106556906860092653394915770695680_inst0" @coreir_lut115790322417210952336529717160220497262186272106556906860092653394915770695680(%I) : (i8) -> (i1)
    %5 = hw.instance "coreir_lut115792089210356248762697446947946071893095522863849111501270640965525260206080_inst0" @coreir_lut115792089210356248762697446947946071893095522863849111501270640965525260206080(%I) : (i8) -> (i1)
    %6 = hw.instance "coreir_lut115792089237316195417293883273301227089774477609353836086800156426807153786880_inst0" @coreir_lut115792089237316195417293883273301227089774477609353836086800156426807153786880(%I) : (i8) -> (i1)
    %7 = hw.instance "coreir_lut115792089237316195423570985008687907852929702298719625575994209400481361428480_inst0" @coreir_lut115792089237316195423570985008687907852929702298719625575994209400481361428480(%I) : (i8) -> (i1)
    %8 = comb.concat %7, %6, %5, %4, %3, %2, %1, %0 : (i1, i1, i1, i1, i1, i1, i1, i1) -> i8
    hw.output %8 : i8
}
hw.module @Tbl(%addr: i8) -> (%out: i8) {
    %0 = hw.instance "LUT_inst0" @LUT(%addr) : (i8) -> (i8)
    hw.output %0 : i8
}