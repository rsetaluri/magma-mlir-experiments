hw.module @complex_aggregates_nested_array(%a: !hw.array<2x!hw.array<3xi4>>) -> (%y: !hw.array<2x!hw.array<3xi4>>) {
    %177 = hw.constant 0 : i1
    %178 = hw.constant 0 : i2
    %179 = hw.constant 1 : i1
    %180 = hw.constant 2 : i2
    %181 = hw.constant 0 : i1
    %182 = hw.constant 0 : i2
    %183 = hw.constant 1 : i1
    %184 = hw.constant 2 : i2
    %185 = hw.constant 0 : i1
    %186 = hw.constant 0 : i2
    %187 = hw.constant 1 : i1
    %188 = hw.constant 2 : i2
    %189 = hw.constant 0 : i1
    %190 = hw.constant 0 : i2
    %191 = hw.constant 1 : i1
    %192 = hw.constant 2 : i2
    %193 = hw.constant 0 : i1
    %194 = hw.constant 1 : i2
    %195 = hw.constant 1 : i1
    %196 = hw.constant 1 : i2
    %197 = hw.constant 0 : i1
    %198 = hw.constant 1 : i2
    %199 = hw.constant 1 : i1
    %200 = hw.constant 1 : i2
    %201 = hw.constant 0 : i1
    %202 = hw.constant 1 : i2
    %203 = hw.constant 1 : i1
    %204 = hw.constant 1 : i2
    %205 = hw.constant 0 : i1
    %206 = hw.constant 1 : i2
    %207 = hw.constant 1 : i1
    %208 = hw.constant 1 : i2
    %209 = hw.constant 0 : i1
    %210 = hw.constant 2 : i2
    %211 = hw.constant 1 : i1
    %212 = hw.constant 0 : i2
    %213 = hw.constant 0 : i1
    %214 = hw.constant 2 : i2
    %215 = hw.constant 1 : i1
    %216 = hw.constant 0 : i2
    %217 = hw.constant 0 : i1
    %218 = hw.constant 2 : i2
    %219 = hw.constant 1 : i1
    %220 = hw.constant 0 : i2
    %221 = hw.constant 0 : i1
    %222 = hw.constant 2 : i2
    %223 = hw.constant 1 : i1
    %224 = hw.constant 0 : i2
    %225 = hw.constant 1 : i1
    %226 = hw.constant 0 : i2
    %227 = hw.constant 0 : i1
    %228 = hw.constant 2 : i2
    %229 = hw.constant 1 : i1
    %230 = hw.constant 0 : i2
    %231 = hw.constant 0 : i1
    %232 = hw.constant 2 : i2
    %233 = hw.constant 1 : i1
    %234 = hw.constant 0 : i2
    %235 = hw.constant 0 : i1
    %236 = hw.constant 2 : i2
    %237 = hw.constant 1 : i1
    %238 = hw.constant 0 : i2
    %239 = hw.constant 0 : i1
    %240 = hw.constant 2 : i2
    %241 = hw.constant 1 : i1
    %242 = hw.constant 1 : i2
    %243 = hw.constant 0 : i1
    %244 = hw.constant 1 : i2
    %245 = hw.constant 1 : i1
    %246 = hw.constant 1 : i2
    %247 = hw.constant 0 : i1
    %248 = hw.constant 1 : i2
    %249 = hw.constant 1 : i1
    %250 = hw.constant 1 : i2
    %251 = hw.constant 0 : i1
    %252 = hw.constant 1 : i2
    %253 = hw.constant 1 : i1
    %254 = hw.constant 1 : i2
    %255 = hw.constant 0 : i1
    %256 = hw.constant 1 : i2
    %257 = hw.constant 1 : i1
    %258 = hw.constant 2 : i2
    %259 = hw.constant 0 : i1
    %260 = hw.constant 0 : i2
    %261 = hw.constant 1 : i1
    %262 = hw.constant 2 : i2
    %263 = hw.constant 0 : i1
    %264 = hw.constant 0 : i2
    %265 = hw.constant 1 : i1
    %266 = hw.constant 2 : i2
    %267 = hw.constant 0 : i1
    %268 = hw.constant 0 : i2
    %269 = hw.constant 1 : i1
    %270 = hw.constant 2 : i2
    %271 = hw.constant 0 : i1
    %272 = hw.constant 0 : i2
    %0 = hw.array_get %a[%177] : !hw.array<2x!hw.array<3xi4>>
    %1 = hw.array_get %a[%179] : !hw.array<2x!hw.array<3xi4>>
    %2 = hw.array_get %a[%181] : !hw.array<2x!hw.array<3xi4>>
    %3 = hw.array_get %a[%183] : !hw.array<2x!hw.array<3xi4>>
    %4 = hw.array_get %a[%185] : !hw.array<2x!hw.array<3xi4>>
    %5 = hw.array_get %a[%187] : !hw.array<2x!hw.array<3xi4>>
    %6 = hw.array_get %a[%189] : !hw.array<2x!hw.array<3xi4>>
    %7 = hw.array_get %a[%191] : !hw.array<2x!hw.array<3xi4>>
    %8 = hw.array_get %a[%193] : !hw.array<2x!hw.array<3xi4>>
    %9 = hw.array_get %a[%195] : !hw.array<2x!hw.array<3xi4>>
    %10 = hw.array_get %a[%197] : !hw.array<2x!hw.array<3xi4>>
    %11 = hw.array_get %a[%199] : !hw.array<2x!hw.array<3xi4>>
    %12 = hw.array_get %a[%201] : !hw.array<2x!hw.array<3xi4>>
    %13 = hw.array_get %a[%203] : !hw.array<2x!hw.array<3xi4>>
    %14 = hw.array_get %a[%205] : !hw.array<2x!hw.array<3xi4>>
    %15 = hw.array_get %a[%207] : !hw.array<2x!hw.array<3xi4>>
    %16 = hw.array_get %a[%209] : !hw.array<2x!hw.array<3xi4>>
    %17 = hw.array_get %a[%211] : !hw.array<2x!hw.array<3xi4>>
    %18 = hw.array_get %a[%213] : !hw.array<2x!hw.array<3xi4>>
    %19 = hw.array_get %a[%215] : !hw.array<2x!hw.array<3xi4>>
    %20 = hw.array_get %a[%217] : !hw.array<2x!hw.array<3xi4>>
    %21 = hw.array_get %a[%219] : !hw.array<2x!hw.array<3xi4>>
    %22 = hw.array_get %a[%221] : !hw.array<2x!hw.array<3xi4>>
    %23 = hw.array_get %a[%223] : !hw.array<2x!hw.array<3xi4>>
    %24 = hw.array_get %a[%225] : !hw.array<2x!hw.array<3xi4>>
    %25 = hw.array_get %a[%227] : !hw.array<2x!hw.array<3xi4>>
    %26 = hw.array_get %a[%229] : !hw.array<2x!hw.array<3xi4>>
    %27 = hw.array_get %a[%231] : !hw.array<2x!hw.array<3xi4>>
    %28 = hw.array_get %a[%233] : !hw.array<2x!hw.array<3xi4>>
    %29 = hw.array_get %a[%235] : !hw.array<2x!hw.array<3xi4>>
    %30 = hw.array_get %a[%237] : !hw.array<2x!hw.array<3xi4>>
    %31 = hw.array_get %a[%239] : !hw.array<2x!hw.array<3xi4>>
    %32 = hw.array_get %a[%241] : !hw.array<2x!hw.array<3xi4>>
    %33 = hw.array_get %a[%243] : !hw.array<2x!hw.array<3xi4>>
    %34 = hw.array_get %a[%245] : !hw.array<2x!hw.array<3xi4>>
    %35 = hw.array_get %a[%247] : !hw.array<2x!hw.array<3xi4>>
    %36 = hw.array_get %a[%249] : !hw.array<2x!hw.array<3xi4>>
    %37 = hw.array_get %a[%251] : !hw.array<2x!hw.array<3xi4>>
    %38 = hw.array_get %a[%253] : !hw.array<2x!hw.array<3xi4>>
    %39 = hw.array_get %a[%255] : !hw.array<2x!hw.array<3xi4>>
    %40 = hw.array_get %a[%257] : !hw.array<2x!hw.array<3xi4>>
    %41 = hw.array_get %a[%259] : !hw.array<2x!hw.array<3xi4>>
    %42 = hw.array_get %a[%261] : !hw.array<2x!hw.array<3xi4>>
    %43 = hw.array_get %a[%263] : !hw.array<2x!hw.array<3xi4>>
    %44 = hw.array_get %a[%265] : !hw.array<2x!hw.array<3xi4>>
    %45 = hw.array_get %a[%267] : !hw.array<2x!hw.array<3xi4>>
    %46 = hw.array_get %a[%269] : !hw.array<2x!hw.array<3xi4>>
    %47 = hw.array_get %a[%271] : !hw.array<2x!hw.array<3xi4>>
    %48 = hw.array_get %0[%178] : !hw.array<3xi4>
    %49 = hw.array_get %1[%180] : !hw.array<3xi4>
    %50 = hw.array_get %2[%182] : !hw.array<3xi4>
    %51 = hw.array_get %3[%184] : !hw.array<3xi4>
    %52 = hw.array_get %4[%186] : !hw.array<3xi4>
    %53 = hw.array_get %5[%188] : !hw.array<3xi4>
    %54 = hw.array_get %6[%190] : !hw.array<3xi4>
    %55 = hw.array_get %7[%192] : !hw.array<3xi4>
    %56 = hw.array_get %8[%194] : !hw.array<3xi4>
    %57 = hw.array_get %9[%196] : !hw.array<3xi4>
    %58 = hw.array_get %10[%198] : !hw.array<3xi4>
    %59 = hw.array_get %11[%200] : !hw.array<3xi4>
    %60 = hw.array_get %12[%202] : !hw.array<3xi4>
    %61 = hw.array_get %13[%204] : !hw.array<3xi4>
    %62 = hw.array_get %14[%206] : !hw.array<3xi4>
    %63 = hw.array_get %15[%208] : !hw.array<3xi4>
    %64 = hw.array_get %16[%210] : !hw.array<3xi4>
    %65 = hw.array_get %17[%212] : !hw.array<3xi4>
    %66 = hw.array_get %18[%214] : !hw.array<3xi4>
    %67 = hw.array_get %19[%216] : !hw.array<3xi4>
    %68 = hw.array_get %20[%218] : !hw.array<3xi4>
    %69 = hw.array_get %21[%220] : !hw.array<3xi4>
    %70 = hw.array_get %22[%222] : !hw.array<3xi4>
    %71 = hw.array_get %23[%224] : !hw.array<3xi4>
    %72 = hw.array_get %24[%226] : !hw.array<3xi4>
    %73 = hw.array_get %25[%228] : !hw.array<3xi4>
    %74 = hw.array_get %26[%230] : !hw.array<3xi4>
    %75 = hw.array_get %27[%232] : !hw.array<3xi4>
    %76 = hw.array_get %28[%234] : !hw.array<3xi4>
    %77 = hw.array_get %29[%236] : !hw.array<3xi4>
    %78 = hw.array_get %30[%238] : !hw.array<3xi4>
    %79 = hw.array_get %31[%240] : !hw.array<3xi4>
    %80 = hw.array_get %32[%242] : !hw.array<3xi4>
    %81 = hw.array_get %33[%244] : !hw.array<3xi4>
    %82 = hw.array_get %34[%246] : !hw.array<3xi4>
    %83 = hw.array_get %35[%248] : !hw.array<3xi4>
    %84 = hw.array_get %36[%250] : !hw.array<3xi4>
    %85 = hw.array_get %37[%252] : !hw.array<3xi4>
    %86 = hw.array_get %38[%254] : !hw.array<3xi4>
    %87 = hw.array_get %39[%256] : !hw.array<3xi4>
    %88 = hw.array_get %40[%258] : !hw.array<3xi4>
    %89 = hw.array_get %41[%260] : !hw.array<3xi4>
    %90 = hw.array_get %42[%262] : !hw.array<3xi4>
    %91 = hw.array_get %43[%264] : !hw.array<3xi4>
    %92 = hw.array_get %44[%266] : !hw.array<3xi4>
    %93 = hw.array_get %45[%268] : !hw.array<3xi4>
    %94 = hw.array_get %46[%270] : !hw.array<3xi4>
    %95 = hw.array_get %47[%272] : !hw.array<3xi4>
    %96 = comb.extract %48 from 0 : (i4) -> i1
    %97 = comb.extract %49 from 3 : (i4) -> i1
    %98 = comb.extract %50 from 1 : (i4) -> i1
    %99 = comb.extract %51 from 2 : (i4) -> i1
    %100 = comb.extract %52 from 2 : (i4) -> i1
    %101 = comb.extract %53 from 1 : (i4) -> i1
    %102 = comb.extract %54 from 3 : (i4) -> i1
    %103 = comb.extract %55 from 0 : (i4) -> i1
    %104 = comb.extract %56 from 0 : (i4) -> i1
    %105 = comb.extract %57 from 3 : (i4) -> i1
    %106 = comb.extract %58 from 1 : (i4) -> i1
    %107 = comb.extract %59 from 2 : (i4) -> i1
    %108 = comb.extract %60 from 2 : (i4) -> i1
    %109 = comb.extract %61 from 1 : (i4) -> i1
    %110 = comb.extract %62 from 3 : (i4) -> i1
    %111 = comb.extract %63 from 0 : (i4) -> i1
    %112 = comb.extract %64 from 0 : (i4) -> i1
    %113 = comb.extract %65 from 3 : (i4) -> i1
    %114 = comb.extract %66 from 1 : (i4) -> i1
    %115 = comb.extract %67 from 2 : (i4) -> i1
    %116 = comb.extract %68 from 2 : (i4) -> i1
    %117 = comb.extract %69 from 1 : (i4) -> i1
    %118 = comb.extract %70 from 3 : (i4) -> i1
    %119 = comb.extract %71 from 0 : (i4) -> i1
    %120 = comb.extract %72 from 0 : (i4) -> i1
    %121 = comb.extract %73 from 3 : (i4) -> i1
    %122 = comb.extract %74 from 1 : (i4) -> i1
    %123 = comb.extract %75 from 2 : (i4) -> i1
    %124 = comb.extract %76 from 2 : (i4) -> i1
    %125 = comb.extract %77 from 1 : (i4) -> i1
    %126 = comb.extract %78 from 3 : (i4) -> i1
    %127 = comb.extract %79 from 0 : (i4) -> i1
    %128 = comb.extract %80 from 0 : (i4) -> i1
    %129 = comb.extract %81 from 3 : (i4) -> i1
    %130 = comb.extract %82 from 1 : (i4) -> i1
    %131 = comb.extract %83 from 2 : (i4) -> i1
    %132 = comb.extract %84 from 2 : (i4) -> i1
    %133 = comb.extract %85 from 1 : (i4) -> i1
    %134 = comb.extract %86 from 3 : (i4) -> i1
    %135 = comb.extract %87 from 0 : (i4) -> i1
    %136 = comb.extract %88 from 0 : (i4) -> i1
    %137 = comb.extract %89 from 3 : (i4) -> i1
    %138 = comb.extract %90 from 1 : (i4) -> i1
    %139 = comb.extract %91 from 2 : (i4) -> i1
    %140 = comb.extract %92 from 2 : (i4) -> i1
    %141 = comb.extract %93 from 1 : (i4) -> i1
    %142 = comb.extract %94 from 3 : (i4) -> i1
    %143 = comb.extract %95 from 0 : (i4) -> i1
    %144 = comb.or %96, %97 : i1
    %145 = comb.or %98, %99 : i1
    %146 = comb.or %100, %101 : i1
    %147 = comb.or %102, %103 : i1
    %148 = comb.or %104, %105 : i1
    %149 = comb.or %106, %107 : i1
    %150 = comb.or %108, %109 : i1
    %151 = comb.or %110, %111 : i1
    %152 = comb.or %112, %113 : i1
    %153 = comb.or %114, %115 : i1
    %154 = comb.or %116, %117 : i1
    %155 = comb.or %118, %119 : i1
    %156 = comb.or %120, %121 : i1
    %157 = comb.or %122, %123 : i1
    %158 = comb.or %124, %125 : i1
    %159 = comb.or %126, %127 : i1
    %160 = comb.or %128, %129 : i1
    %161 = comb.or %130, %131 : i1
    %162 = comb.or %132, %133 : i1
    %163 = comb.or %134, %135 : i1
    %164 = comb.or %136, %137 : i1
    %165 = comb.or %138, %139 : i1
    %166 = comb.or %140, %141 : i1
    %167 = comb.or %142, %143 : i1
    %168 = comb.concat %147, %146, %145, %144 : (i1, i1, i1, i1) -> i4
    %169 = comb.concat %151, %150, %149, %148 : (i1, i1, i1, i1) -> i4
    %170 = comb.concat %155, %154, %153, %152 : (i1, i1, i1, i1) -> i4
    %171 = comb.concat %159, %158, %157, %156 : (i1, i1, i1, i1) -> i4
    %172 = comb.concat %163, %162, %161, %160 : (i1, i1, i1, i1) -> i4
    %173 = comb.concat %167, %166, %165, %164 : (i1, i1, i1, i1) -> i4
    %174 = hw.array_create %170, %169, %168 : i4
    %175 = hw.array_create %173, %172, %171 : i4
    %176 = hw.array_create %175, %174 : !hw.array<3xi4>
    hw.output %176 : !hw.array<2x!hw.array<3xi4>>
}