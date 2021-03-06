#version 460
#extension GL_ARB_gpu_shader_int64 : require
#extension GL_NV_ray_tracing : require
#extension GL_EXT_buffer_reference : require
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_EXT_samplerless_texture_functions : require

struct _38
{
    vec4 _m0;
    uint _m1;
};

layout(buffer_reference) buffer vec4Pointer
{
    vec4 value;
};

layout(buffer_reference) buffer uintPointer
{
    uint value;
};

layout(buffer_reference) buffer uvec2Pointer
{
    uvec2 value;
};

layout(buffer_reference) buffer uvec3Pointer
{
    uvec3 value;
};

layout(buffer_reference) buffer uvec4Pointer
{
    uvec4 value;
};

layout(buffer_reference) buffer floatPointer
{
    float value;
};

layout(shaderRecordNV, std430) buffer SBTBlock
{
    uint _m0[5];
    uint _m1[6];
    uint64_t _m2;
    uint64_t _m3;
    uint64_t _m4;
    uint64_t _m5;
    uint64_t _m6;
    uvec2 _m7;
    uvec2 _m8;
    uvec2 _m9;
    uvec2 _m10;
} SBT;

layout(set = 5, binding = 0, std140) uniform BindlessCBV
{
    vec4 _m0[4096];
} _33[];

layout(push_constant, std430) uniform RootConstants
{
    uint _m0;
    uint _m1;
    uint _m2;
    uint _m3;
    uint _m4;
    uint _m5;
    uint _m6;
    uint _m7;
} registers;

layout(set = 0, binding = 0) uniform texture2D _22[];
layout(set = 3, binding = 0, r32f) uniform readonly image2D _26[];
layout(set = 2, binding = 0) uniform sampler _37[];
layout(location = 0) rayPayloadInNV _38 payload;

uint _291;
float _358;
uint _372;
vec4 _380;
float _389;

void main()
{
    uint _54 = (SBT._m9.x >> 6u) + 12u;
    uint _59 = payload._m1;
    vec4 _70 = texelFetch(_22[nonuniformEXT(registers._m0 + (_59 & 1u))], ivec2(uvec2(0u)), int(0u));
    vec4 _83 = texelFetch(_22[nonuniformEXT(registers._m0 + _59)], ivec2(uvec2(0u)), int(0u));
    vec4 _102 = texelFetch(_22[nonuniformEXT(((SBT._m7.x >> 6u) + 17u) + _59)], ivec2(uvec2(0u)), int(0u));
    vec4 _122 = imageLoad(_26[nonuniformEXT(((SBT._m8.x >> 6u) + 18u) + _59)], ivec2(uvec2(0u)));
    uint _149 = ((SBT._m9.x >> 6u) + 13u) + _59;
    vec4 _172 = uintBitsToFloat(uvec4(SBT._m0[0u], SBT._m0[1u], SBT._m0[2u], SBT._m0[3u]));
    vec4 _185 = uintBitsToFloat(uvec4(SBT._m0[4u], 0u, 0u, 0u));
    vec4Pointer _199 = vec4Pointer(SBT._m6 + uint64_t(1u * 16u));
    uint _209 = payload._m1;
    vec4 _228 = textureLodOffset(sampler2D(_22[nonuniformEXT(registers._m0 + (_209 & 1u))], _37[nonuniformEXT((SBT._m10.x >> 5u) + 13u)]), vec2(0.5), 0.0, ivec2(0));
    vec4 _256 = textureLodOffset(sampler2D(_22[nonuniformEXT(registers._m0 + _209)], _37[nonuniformEXT(((SBT._m10.x >> 5u) + 14u) + (_209 ^ 1u))]), vec2(0.5), 0.0, ivec2(0));
    vec4Pointer _272 = vec4Pointer(SBT._m2 + uint64_t((_209 * 16u) + 0u));
    float _293 = uintBitsToFloat(uvec2(uintPointer(SBT._m4 + uint64_t(_209 << 2u)).value, _291).x);
    uvec2Pointer _302 = uvec2Pointer(SBT._m4 + uint64_t(_209 << 3u));
    float _306 = uintBitsToFloat(_302.value.x);
    float _307 = uintBitsToFloat(_302.value.y);
    uvec3Pointer _317 = uvec3Pointer(SBT._m4 + uint64_t(_209 * 12u));
    float _324 = uintBitsToFloat(_317.value.z);
    uint _329 = payload._m1;
    uvec4Pointer _334 = uvec4Pointer(SBT._m4 + uint64_t(_329 << 4u));
    vec2 _357 = vec2(floatPointer(SBT._m3 + uint64_t((_329 * 4u) + 0u)).value, _358);
    float _359 = _357.x;
    uint _364 = _329 << 2u;
    float _374 = uintBitsToFloat(uvec2(uintPointer(SBT._m5 + uint64_t(_364)).value, _372).x);
    float _375 = ((((((((((((((((_70.x + _83.x) + _102.x) + _122.x) + _33[nonuniformEXT(_54)]._m0[0u].x) + _33[nonuniformEXT(_149)]._m0[0u].x) + _172.x) + _185.x) + _199.value.x) + _228.x) + _256.x) + _272.value.x) + _293) + _306) + uintBitsToFloat(_317.value.x)) + uintBitsToFloat(_334.value.x)) + _359) + _374;
    float _376 = ((((((((((((((((_70.y + _83.y) + _102.y) + _122.y) + _33[nonuniformEXT(_54)]._m0[0u].y) + _33[nonuniformEXT(_149)]._m0[0u].y) + _172.y) + _185.y) + _199.value.y) + _228.y) + _256.y) + _272.value.y) + _293) + _307) + uintBitsToFloat(_317.value.y)) + uintBitsToFloat(_334.value.y)) + _359) + _374;
    vec4 _379 = _380;
    _379.x = _375;
    vec4 _381 = _379;
    _381.y = _376;
    vec4 _382 = _381;
    _382.z = ((((((((((((((((_70.z + _83.z) + _102.z) + _122.z) + _33[nonuniformEXT(_54)]._m0[0u].z) + _33[nonuniformEXT(_149)]._m0[0u].z) + _172.z) + _185.z) + _199.value.z) + _228.z) + _256.z) + _272.value.z) + _293) + _306) + _324) + uintBitsToFloat(_334.value.z)) + _359) + _374;
    vec4 _383 = _382;
    _383.w = ((((((((((((((((_70.w + _83.w) + _102.w) + _122.w) + _33[nonuniformEXT(_54)]._m0[0u].w) + _33[nonuniformEXT(_149)]._m0[0u].w) + _172.w) + _185.w) + _199.value.w) + _228.w) + _256.w) + _272.value.w) + _293) + _307) + _324) + uintBitsToFloat(_334.value.w)) + _359) + _374;
    payload._m0 = _383;
    floatPointer(SBT._m3 + uint64_t((_329 * 4u) + 0u)).value = _375;
    floatPointer(SBT._m5 + uint64_t(_364)).value = _376;
}


#if 0
// SPIR-V disassembly
; SPIR-V
; Version: 1.3
; Generator: Unknown(30017); 21022
; Bound: 397
; Schema: 0
OpCapability Shader
OpCapability Int64
OpCapability UniformBufferArrayDynamicIndexing
OpCapability SampledImageArrayDynamicIndexing
OpCapability StorageBufferArrayDynamicIndexing
OpCapability StorageImageArrayDynamicIndexing
OpCapability RuntimeDescriptorArray
OpCapability UniformBufferArrayNonUniformIndexing
OpCapability SampledImageArrayNonUniformIndexing
OpCapability StorageBufferArrayNonUniformIndexing
OpCapability StorageImageArrayNonUniformIndexing
OpCapability PhysicalStorageBufferAddresses
OpCapability RayTracingProvisionalKHR
OpExtension "SPV_EXT_descriptor_indexing"
OpExtension "SPV_KHR_physical_storage_buffer"
OpExtension "SPV_KHR_ray_tracing"
OpMemoryModel PhysicalStorageBuffer64 GLSL450
OpEntryPoint MissNV %3 "main"
OpName %3 "main"
OpName %6 "RootConstants"
OpName %8 "registers"
OpName %15 "SBTBlock"
OpName %17 "SBT"
OpName %30 "BindlessCBV"
OpName %38 ""
OpName %40 "payload"
OpDecorate %6 Block
OpMemberDecorate %6 0 Offset 0
OpMemberDecorate %6 1 Offset 4
OpMemberDecorate %6 2 Offset 8
OpMemberDecorate %6 3 Offset 12
OpMemberDecorate %6 4 Offset 16
OpMemberDecorate %6 5 Offset 20
OpMemberDecorate %6 6 Offset 24
OpMemberDecorate %6 7 Offset 28
OpDecorate %10 ArrayStride 4
OpDecorate %12 ArrayStride 4
OpDecorate %15 Block
OpMemberDecorate %15 0 Offset 0
OpMemberDecorate %15 1 Offset 20
OpMemberDecorate %15 2 Offset 48
OpMemberDecorate %15 3 Offset 56
OpMemberDecorate %15 4 Offset 64
OpMemberDecorate %15 5 Offset 72
OpMemberDecorate %15 6 Offset 80
OpMemberDecorate %15 7 Offset 88
OpMemberDecorate %15 8 Offset 96
OpMemberDecorate %15 9 Offset 104
OpMemberDecorate %15 10 Offset 112
OpDecorate %22 DescriptorSet 0
OpDecorate %22 Binding 0
OpDecorate %26 DescriptorSet 3
OpDecorate %26 Binding 0
OpDecorate %26 NonWritable
OpDecorate %29 ArrayStride 16
OpDecorate %30 Block
OpMemberDecorate %30 0 Offset 0
OpDecorate %33 DescriptorSet 5
OpDecorate %33 Binding 0
OpDecorate %37 DescriptorSet 2
OpDecorate %37 Binding 0
OpDecorate %40 Location 0
OpDecorate %48 NonUniform
OpDecorate %60 NonUniform
OpDecorate %67 NonUniform
OpDecorate %59 NonUniform
OpDecorate %82 NonUniform
OpDecorate %59 NonUniform
OpDecorate %101 NonUniform
OpDecorate %59 NonUniform
OpDecorate %121 NonUniform
OpDecorate %133 NonUniform
OpDecorate %143 NonUniform
OpDecorate %150 NonUniform
OpDecorate %210 NonUniform
OpDecorate %215 NonUniform
OpDecorate %223 NonUniform
OpDecorate %225 NonUniform
OpDecorate %209 NonUniform
OpDecorate %246 NonUniform
OpDecorate %241 NonUniform
OpDecorate %254 NonUniform
OpDecorate %255 NonUniform
%1 = OpTypeVoid
%2 = OpTypeFunction %1
%5 = OpTypeInt 32 0
%6 = OpTypeStruct %5 %5 %5 %5 %5 %5 %5 %5
%7 = OpTypePointer PushConstant %6
%8 = OpVariable %7 PushConstant
%9 = OpConstant %5 5
%10 = OpTypeArray %5 %9
%11 = OpConstant %5 6
%12 = OpTypeArray %5 %11
%13 = OpTypeInt 64 0
%14 = OpTypeVector %5 2
%15 = OpTypeStruct %10 %12 %13 %13 %13 %13 %13 %14 %14 %14 %14
%16 = OpTypePointer ShaderRecordBufferNV %15
%17 = OpVariable %16 ShaderRecordBufferNV
%18 = OpTypeFloat 32
%19 = OpTypeImage %18 2D 0 0 0 1 Unknown
%20 = OpTypeRuntimeArray %19
%21 = OpTypePointer UniformConstant %20
%22 = OpVariable %21 UniformConstant
%23 = OpTypeImage %18 2D 0 0 0 2 R32f
%24 = OpTypeRuntimeArray %23
%25 = OpTypePointer UniformConstant %24
%26 = OpVariable %25 UniformConstant
%27 = OpTypeVector %18 4
%28 = OpConstant %5 4096
%29 = OpTypeArray %27 %28
%30 = OpTypeStruct %29
%31 = OpTypeRuntimeArray %30
%32 = OpTypePointer Uniform %31
%33 = OpVariable %32 Uniform
%34 = OpTypeSampler
%35 = OpTypeRuntimeArray %34
%36 = OpTypePointer UniformConstant %35
%37 = OpVariable %36 UniformConstant
%38 = OpTypeStruct %27 %5
%39 = OpTypePointer IncomingRayPayloadNV %38
%40 = OpVariable %39 IncomingRayPayloadNV
%41 = OpTypePointer ShaderRecordBufferNV %13
%44 = OpTypePointer ShaderRecordBufferNV %10
%46 = OpConstant %5 0
%47 = OpTypePointer Uniform %30
%49 = OpTypePointer ShaderRecordBufferNV %5
%51 = OpConstant %5 9
%55 = OpConstant %5 12
%56 = OpTypePointer IncomingRayPayloadNV %5
%58 = OpConstant %5 1
%61 = OpTypePointer UniformConstant %19
%63 = OpTypePointer PushConstant %5
%68 = OpTypeInt 32 1
%69 = OpConstant %68 0
%76 = OpTypePointer IncomingRayPayloadNV %27
%95 = OpConstant %5 7
%99 = OpConstant %5 17
%112 = OpTypePointer UniformConstant %23
%115 = OpConstant %5 8
%119 = OpConstant %5 18
%132 = OpTypePointer Uniform %27
%148 = OpConstant %5 13
%165 = OpConstant %5 2
%168 = OpConstant %5 3
%170 = OpTypeVector %5 4
%182 = OpConstant %5 4
%195 = OpConstant %5 16
%198 = OpTypePointer PhysicalStorageBuffer %27
%216 = OpTypePointer UniformConstant %34
%219 = OpConstant %5 10
%224 = OpTypeSampledImage %19
%226 = OpConstant %18 0.5
%227 = OpConstant %18 0
%229 = OpTypeVector %18 2
%231 = OpTypeVector %68 2
%232 = OpConstantComposite %231 %69 %69
%252 = OpConstant %5 14
%285 = OpTypePointer PhysicalStorageBuffer %5
%299 = OpTypePointer PhysicalStorageBuffer %14
%313 = OpTypeVector %5 3
%314 = OpTypePointer PhysicalStorageBuffer %313
%331 = OpTypePointer PhysicalStorageBuffer %170
%350 = OpTypePointer PhysicalStorageBuffer %18
%3 = OpFunction %1 None %2
%4 = OpLabel
%291 = OpUndef %5
%358 = OpUndef %18
%372 = OpUndef %5
%380 = OpUndef %27
%389 = OpUndef %18
OpBranch %395
%395 = OpLabel
%42 = OpAccessChain %41 %17 %11
%43 = OpLoad %13 %42
%45 = OpAccessChain %44 %17 %46
%50 = OpAccessChain %49 %17 %51 %46
%52 = OpLoad %5 %50
%53 = OpShiftRightLogical %5 %52 %11
%54 = OpIAdd %5 %53 %55
%48 = OpAccessChain %47 %33 %54
%57 = OpInBoundsAccessChain %56 %40 %58
%59 = OpLoad %5 %57
%60 = OpBitwiseAnd %5 %59 %58
%64 = OpAccessChain %63 %8 %46
%65 = OpLoad %5 %64
%66 = OpIAdd %5 %65 %60
%62 = OpAccessChain %61 %22 %66
%67 = OpLoad %19 %62
%71 = OpCompositeConstruct %14 %46 %46
%70 = OpImageFetch %27 %67 %71 Lod %46
%72 = OpCompositeExtract %18 %70 0
%73 = OpCompositeExtract %18 %70 1
%74 = OpCompositeExtract %18 %70 2
%75 = OpCompositeExtract %18 %70 3
%77 = OpInBoundsAccessChain %76 %40 %46
%79 = OpAccessChain %63 %8 %46
%80 = OpLoad %5 %79
%81 = OpIAdd %5 %80 %59
%78 = OpAccessChain %61 %22 %81
%82 = OpLoad %19 %78
%84 = OpCompositeConstruct %14 %46 %46
%83 = OpImageFetch %27 %82 %84 Lod %46
%85 = OpCompositeExtract %18 %83 0
%86 = OpCompositeExtract %18 %83 1
%87 = OpCompositeExtract %18 %83 2
%88 = OpCompositeExtract %18 %83 3
%89 = OpFAdd %18 %72 %85
%90 = OpFAdd %18 %73 %86
%91 = OpFAdd %18 %74 %87
%92 = OpFAdd %18 %75 %88
%94 = OpAccessChain %49 %17 %95 %46
%96 = OpLoad %5 %94
%97 = OpShiftRightLogical %5 %96 %11
%98 = OpIAdd %5 %97 %99
%100 = OpIAdd %5 %98 %59
%93 = OpAccessChain %61 %22 %100
%101 = OpLoad %19 %93
%103 = OpCompositeConstruct %14 %46 %46
%102 = OpImageFetch %27 %101 %103 Lod %46
%104 = OpCompositeExtract %18 %102 0
%105 = OpCompositeExtract %18 %102 1
%106 = OpCompositeExtract %18 %102 2
%107 = OpCompositeExtract %18 %102 3
%108 = OpFAdd %18 %89 %104
%109 = OpFAdd %18 %90 %105
%110 = OpFAdd %18 %91 %106
%111 = OpFAdd %18 %92 %107
%114 = OpAccessChain %49 %17 %115 %46
%116 = OpLoad %5 %114
%117 = OpShiftRightLogical %5 %116 %11
%118 = OpIAdd %5 %117 %119
%120 = OpIAdd %5 %118 %59
%113 = OpAccessChain %112 %26 %120
%121 = OpLoad %23 %113
%123 = OpCompositeConstruct %14 %46 %46
%122 = OpImageRead %27 %121 %123 None
%124 = OpCompositeExtract %18 %122 0
%125 = OpCompositeExtract %18 %122 1
%126 = OpCompositeExtract %18 %122 2
%127 = OpCompositeExtract %18 %122 3
%128 = OpFAdd %18 %108 %124
%129 = OpFAdd %18 %109 %125
%130 = OpFAdd %18 %110 %126
%131 = OpFAdd %18 %111 %127
%133 = OpAccessChain %132 %48 %46 %46
%134 = OpLoad %27 %133
%135 = OpCompositeExtract %18 %134 0
%136 = OpCompositeExtract %18 %134 1
%137 = OpCompositeExtract %18 %134 2
%138 = OpCompositeExtract %18 %134 3
%139 = OpFAdd %18 %128 %135
%140 = OpFAdd %18 %129 %136
%141 = OpFAdd %18 %130 %137
%142 = OpFAdd %18 %131 %138
%144 = OpAccessChain %49 %17 %51 %46
%145 = OpLoad %5 %144
%146 = OpShiftRightLogical %5 %145 %11
%147 = OpIAdd %5 %146 %148
%149 = OpIAdd %5 %147 %59
%143 = OpAccessChain %47 %33 %149
%150 = OpAccessChain %132 %143 %46 %46
%151 = OpLoad %27 %150
%152 = OpCompositeExtract %18 %151 0
%153 = OpCompositeExtract %18 %151 1
%154 = OpCompositeExtract %18 %151 2
%155 = OpCompositeExtract %18 %151 3
%156 = OpFAdd %18 %139 %152
%157 = OpFAdd %18 %140 %153
%158 = OpFAdd %18 %141 %154
%159 = OpFAdd %18 %142 %155
%160 = OpAccessChain %49 %45 %46
%161 = OpLoad %5 %160
%162 = OpAccessChain %49 %45 %58
%163 = OpLoad %5 %162
%164 = OpAccessChain %49 %45 %165
%166 = OpLoad %5 %164
%167 = OpAccessChain %49 %45 %168
%169 = OpLoad %5 %167
%171 = OpCompositeConstruct %170 %161 %163 %166 %169
%172 = OpBitcast %27 %171
%173 = OpCompositeExtract %18 %172 0
%174 = OpCompositeExtract %18 %172 1
%175 = OpCompositeExtract %18 %172 2
%176 = OpCompositeExtract %18 %172 3
%177 = OpFAdd %18 %156 %173
%178 = OpFAdd %18 %157 %174
%179 = OpFAdd %18 %158 %175
%180 = OpFAdd %18 %159 %176
%181 = OpAccessChain %49 %45 %182
%183 = OpLoad %5 %181
%184 = OpCompositeConstruct %170 %183 %46 %46 %46
%185 = OpBitcast %27 %184
%186 = OpCompositeExtract %18 %185 0
%187 = OpCompositeExtract %18 %185 1
%188 = OpCompositeExtract %18 %185 2
%189 = OpCompositeExtract %18 %185 3
%190 = OpFAdd %18 %177 %186
%191 = OpFAdd %18 %178 %187
%192 = OpFAdd %18 %179 %188
%193 = OpFAdd %18 %180 %189
%194 = OpIMul %5 %58 %195
%196 = OpUConvert %13 %194
%197 = OpIAdd %13 %43 %196
%199 = OpBitcast %198 %197
%200 = OpLoad %27 %199 Aligned 16
%201 = OpCompositeExtract %18 %200 0
%202 = OpCompositeExtract %18 %200 1
%203 = OpCompositeExtract %18 %200 2
%204 = OpCompositeExtract %18 %200 3
%205 = OpFAdd %18 %190 %201
%206 = OpFAdd %18 %191 %202
%207 = OpFAdd %18 %192 %203
%208 = OpFAdd %18 %193 %204
%209 = OpLoad %5 %57
%210 = OpBitwiseAnd %5 %209 %58
%212 = OpAccessChain %63 %8 %46
%213 = OpLoad %5 %212
%214 = OpIAdd %5 %213 %210
%211 = OpAccessChain %61 %22 %214
%215 = OpLoad %19 %211
%218 = OpAccessChain %49 %17 %219 %46
%220 = OpLoad %5 %218
%221 = OpShiftRightLogical %5 %220 %9
%222 = OpIAdd %5 %221 %148
%217 = OpAccessChain %216 %37 %222
%223 = OpLoad %34 %217
%225 = OpSampledImage %224 %215 %223
%230 = OpCompositeConstruct %229 %226 %226
%228 = OpImageSampleExplicitLod %27 %225 %230 Lod|ConstOffset %227 %232
%233 = OpCompositeExtract %18 %228 0
%234 = OpCompositeExtract %18 %228 1
%235 = OpCompositeExtract %18 %228 2
%236 = OpCompositeExtract %18 %228 3
%237 = OpFAdd %18 %205 %233
%238 = OpFAdd %18 %206 %234
%239 = OpFAdd %18 %207 %235
%240 = OpFAdd %18 %208 %236
%241 = OpBitwiseXor %5 %209 %58
%243 = OpAccessChain %63 %8 %46
%244 = OpLoad %5 %243
%245 = OpIAdd %5 %244 %209
%242 = OpAccessChain %61 %22 %245
%246 = OpLoad %19 %242
%248 = OpAccessChain %49 %17 %219 %46
%249 = OpLoad %5 %248
%250 = OpShiftRightLogical %5 %249 %9
%251 = OpIAdd %5 %250 %252
%253 = OpIAdd %5 %251 %241
%247 = OpAccessChain %216 %37 %253
%254 = OpLoad %34 %247
%255 = OpSampledImage %224 %246 %254
%257 = OpCompositeConstruct %229 %226 %226
%256 = OpImageSampleExplicitLod %27 %255 %257 Lod|ConstOffset %227 %232
%258 = OpCompositeExtract %18 %256 0
%259 = OpCompositeExtract %18 %256 1
%260 = OpCompositeExtract %18 %256 2
%261 = OpCompositeExtract %18 %256 3
%262 = OpFAdd %18 %237 %258
%263 = OpFAdd %18 %238 %259
%264 = OpFAdd %18 %239 %260
%265 = OpFAdd %18 %240 %261
%266 = OpAccessChain %41 %17 %165
%267 = OpLoad %13 %266
%268 = OpIMul %5 %209 %195
%269 = OpIAdd %5 %268 %46
%270 = OpUConvert %13 %269
%271 = OpIAdd %13 %267 %270
%272 = OpBitcast %198 %271
%273 = OpLoad %27 %272 Aligned 4
%274 = OpCompositeExtract %18 %273 0
%275 = OpCompositeExtract %18 %273 1
%276 = OpCompositeExtract %18 %273 2
%277 = OpCompositeExtract %18 %273 3
%278 = OpFAdd %18 %262 %274
%279 = OpFAdd %18 %263 %275
%280 = OpFAdd %18 %264 %276
%281 = OpFAdd %18 %265 %277
%282 = OpShiftLeftLogical %5 %209 %165
%283 = OpAccessChain %41 %17 %182
%284 = OpLoad %13 %283
%286 = OpUConvert %13 %282
%287 = OpIAdd %13 %284 %286
%288 = OpBitcast %285 %287
%289 = OpLoad %5 %288 Aligned 4
%290 = OpCompositeConstruct %14 %289 %291
%292 = OpCompositeExtract %5 %290 0
%293 = OpBitcast %18 %292
%294 = OpFAdd %18 %278 %293
%295 = OpFAdd %18 %279 %293
%296 = OpFAdd %18 %280 %293
%297 = OpFAdd %18 %281 %293
%298 = OpShiftLeftLogical %5 %209 %168
%300 = OpUConvert %13 %298
%301 = OpIAdd %13 %284 %300
%302 = OpBitcast %299 %301
%303 = OpLoad %14 %302 Aligned 4
%304 = OpCompositeExtract %5 %303 0
%305 = OpCompositeExtract %5 %303 1
%306 = OpBitcast %18 %304
%307 = OpBitcast %18 %305
%308 = OpFAdd %18 %294 %306
%309 = OpFAdd %18 %295 %307
%310 = OpFAdd %18 %296 %306
%311 = OpFAdd %18 %297 %307
%312 = OpIMul %5 %209 %55
%315 = OpUConvert %13 %312
%316 = OpIAdd %13 %284 %315
%317 = OpBitcast %314 %316
%318 = OpLoad %313 %317 Aligned 4
%319 = OpCompositeExtract %5 %318 0
%320 = OpCompositeExtract %5 %318 1
%321 = OpCompositeExtract %5 %318 2
%322 = OpBitcast %18 %319
%323 = OpBitcast %18 %320
%324 = OpBitcast %18 %321
%325 = OpFAdd %18 %308 %322
%326 = OpFAdd %18 %309 %323
%327 = OpFAdd %18 %310 %324
%328 = OpFAdd %18 %311 %324
%329 = OpLoad %5 %57
%330 = OpShiftLeftLogical %5 %329 %182
%332 = OpUConvert %13 %330
%333 = OpIAdd %13 %284 %332
%334 = OpBitcast %331 %333
%335 = OpLoad %170 %334 Aligned 4
%336 = OpCompositeExtract %5 %335 0
%337 = OpCompositeExtract %5 %335 1
%338 = OpCompositeExtract %5 %335 2
%339 = OpCompositeExtract %5 %335 3
%340 = OpBitcast %18 %336
%341 = OpBitcast %18 %337
%342 = OpBitcast %18 %338
%343 = OpBitcast %18 %339
%344 = OpFAdd %18 %325 %340
%345 = OpFAdd %18 %326 %341
%346 = OpFAdd %18 %327 %342
%347 = OpFAdd %18 %328 %343
%348 = OpAccessChain %41 %17 %168
%349 = OpLoad %13 %348
%351 = OpIMul %5 %329 %182
%352 = OpIAdd %5 %351 %46
%353 = OpUConvert %13 %352
%354 = OpIAdd %13 %349 %353
%355 = OpBitcast %350 %354
%356 = OpLoad %18 %355 Aligned 4
%357 = OpCompositeConstruct %229 %356 %358
%359 = OpCompositeExtract %18 %357 0
%360 = OpFAdd %18 %344 %359
%361 = OpFAdd %18 %345 %359
%362 = OpFAdd %18 %346 %359
%363 = OpFAdd %18 %347 %359
%364 = OpShiftLeftLogical %5 %329 %165
%365 = OpAccessChain %41 %17 %9
%366 = OpLoad %13 %365
%367 = OpUConvert %13 %364
%368 = OpIAdd %13 %366 %367
%369 = OpBitcast %285 %368
%370 = OpLoad %5 %369 Aligned 4
%371 = OpCompositeConstruct %14 %370 %372
%373 = OpCompositeExtract %5 %371 0
%374 = OpBitcast %18 %373
%375 = OpFAdd %18 %360 %374
%376 = OpFAdd %18 %361 %374
%377 = OpFAdd %18 %362 %374
%378 = OpFAdd %18 %363 %374
%379 = OpCompositeInsert %27 %375 %380 0
%381 = OpCompositeInsert %27 %376 %379 1
%382 = OpCompositeInsert %27 %377 %381 2
%383 = OpCompositeInsert %27 %378 %382 3
OpStore %77 %383
%384 = OpIMul %5 %329 %182
%385 = OpIAdd %5 %384 %46
%386 = OpUConvert %13 %385
%387 = OpIAdd %13 %349 %386
%388 = OpBitcast %350 %387
OpStore %388 %375 Aligned 4
%390 = OpAccessChain %41 %17 %9
%391 = OpLoad %13 %390
%392 = OpUConvert %13 %364
%393 = OpIAdd %13 %391 %392
%394 = OpBitcast %350 %393
OpStore %394 %376 Aligned 4
OpReturn
OpFunctionEnd
#endif
