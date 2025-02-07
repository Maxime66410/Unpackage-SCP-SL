Shader "CameraFilterPack/Distortion_Twist" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_TimeX ("Time", Range(0, 1)) = 1
		_Distortion ("_Distortion", Range(0, 1)) = 0.3
		_ScreenResolution ("_ScreenResolution", Vector) = (0,0,0,0)
		_CenterX ("_CenterX", Range(-1, 1)) = 0
		_CenterY ("_CenterY", Range(-1, 1)) = 0
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 53366
			Program "vp" {
				SubProgram "d3d11 " {
					"!!vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!!!GL3x
					#ifdef VERTEX
					#version 150
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_shader_bit_encoding
					#extension GL_ARB_shader_bit_encoding : enable
					#endif
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 150
					#extension GL_ARB_explicit_attrib_location : require
					#ifdef GL_ARB_shader_bit_encoding
					#extension GL_ARB_shader_bit_encoding : enable
					#endif
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform 	float _Distortion;
					uniform 	float _CenterX;
					uniform 	float _CenterY;
					uniform 	float _Size;
					uniform 	vec4 _MainTex_ST;
					UNITY_LOCATION(0) uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec2 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					float u_xlat4;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = sin(_Distortion);
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3.xy = u_xlat3.xy + (-vec2(_CenterX, _CenterY));
					    u_xlat9 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat1.x = _Size * 0.5 + (-u_xlat9);
					    u_xlat4 = _Size * 0.5;
					    u_xlat1.x = u_xlat1.x / u_xlat4;
					    u_xlatb9 = u_xlat9<u_xlat4;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 16.0;
					    u_xlat1.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.x);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat2.z = u_xlat0.x;
					    u_xlat1.y = dot(u_xlat3.yx, u_xlat2.yz);
					    u_xlat1.x = dot(u_xlat3.yx, u_xlat2.xy);
					    u_xlat0.xy = (bool(u_xlatb9)) ? u_xlat1.xy : u_xlat3.xy;
					    u_xlat0.xy = u_xlat0.xy + vec2(_CenterX, _CenterY);
					    SV_Target0 = texture(_MainTex, u_xlat0.xy);
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan " {
					"!!vulkan
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 97
					; Schema: 0
					                                              OpCapability Shader 
					                                       %1 = OpExtInstImport "GLSL.std.450" 
					                                              OpMemoryModel Logical GLSL450 
					                                              OpEntryPoint Vertex %4 "main" %9 %11 %17 %78 %88 %89 
					                                              OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                              OpDecorate vs_TEXCOORD0 Location 9 
					                                              OpDecorate %11 Location 11 
					                                              OpDecorate %17 Location 17 
					                                              OpDecorate %22 ArrayStride 22 
					                                              OpDecorate %23 ArrayStride 23 
					                                              OpMemberDecorate %24 0 Offset 24 
					                                              OpMemberDecorate %24 1 Offset 24 
					                                              OpDecorate %24 Block 
					                                              OpDecorate %26 DescriptorSet 26 
					                                              OpDecorate %26 Binding 26 
					                                              OpMemberDecorate %76 0 BuiltIn 76 
					                                              OpMemberDecorate %76 1 BuiltIn 76 
					                                              OpMemberDecorate %76 2 BuiltIn 76 
					                                              OpDecorate %76 Block 
					                                              OpDecorate %88 Location 88 
					                                              OpDecorate %89 Location 89 
					                                       %2 = OpTypeVoid 
					                                       %3 = OpTypeFunction %2 
					                                       %6 = OpTypeFloat 32 
					                                       %7 = OpTypeVector %6 2 
					                                       %8 = OpTypePointer Output %7 
					               Output f32_2* vs_TEXCOORD0 = OpVariable Output 
					                                      %10 = OpTypePointer Input %7 
					                         Input f32_2* %11 = OpVariable Input 
					                                      %13 = OpTypeVector %6 4 
					                                      %14 = OpTypePointer Private %13 
					                       Private f32_4* %15 = OpVariable Private 
					                                      %16 = OpTypePointer Input %13 
					                         Input f32_4* %17 = OpVariable Input 
					                                      %20 = OpTypeInt 32 0 
					                                  u32 %21 = OpConstant 4 
					                                      %22 = OpTypeArray %13 %21 
					                                      %23 = OpTypeArray %13 %21 
					                                      %24 = OpTypeStruct %22 %23 
					                                      %25 = OpTypePointer Uniform %24 
					Uniform struct {f32_4[4]; f32_4[4];}* %26 = OpVariable Uniform 
					                                      %27 = OpTypeInt 32 1 
					                                  i32 %28 = OpConstant 0 
					                                  i32 %29 = OpConstant 1 
					                                      %30 = OpTypePointer Uniform %13 
					                                  i32 %41 = OpConstant 2 
					                                  i32 %50 = OpConstant 3 
					                       Private f32_4* %54 = OpVariable Private 
					                                  u32 %74 = OpConstant 1 
					                                      %75 = OpTypeArray %6 %74 
					                                      %76 = OpTypeStruct %13 %6 %75 
					                                      %77 = OpTypePointer Output %76 
					 Output struct {f32_4; f32; f32[1];}* %78 = OpVariable Output 
					                                      %86 = OpTypePointer Output %13 
					                        Output f32_4* %88 = OpVariable Output 
					                         Input f32_4* %89 = OpVariable Input 
					                                      %91 = OpTypePointer Output %6 
					                                  void %4 = OpFunction None %3 
					                                       %5 = OpLabel 
					                                f32_2 %12 = OpLoad %11 
					                                              OpStore vs_TEXCOORD0 %12 
					                                f32_4 %18 = OpLoad %17 
					                                f32_4 %19 = OpVectorShuffle %18 %18 1 1 1 1 
					                       Uniform f32_4* %31 = OpAccessChain %26 %28 %29 
					                                f32_4 %32 = OpLoad %31 
					                                f32_4 %33 = OpFMul %19 %32 
					                                              OpStore %15 %33 
					                       Uniform f32_4* %34 = OpAccessChain %26 %28 %28 
					                                f32_4 %35 = OpLoad %34 
					                                f32_4 %36 = OpLoad %17 
					                                f32_4 %37 = OpVectorShuffle %36 %36 0 0 0 0 
					                                f32_4 %38 = OpFMul %35 %37 
					                                f32_4 %39 = OpLoad %15 
					                                f32_4 %40 = OpFAdd %38 %39 
					                                              OpStore %15 %40 
					                       Uniform f32_4* %42 = OpAccessChain %26 %28 %41 
					                                f32_4 %43 = OpLoad %42 
					                                f32_4 %44 = OpLoad %17 
					                                f32_4 %45 = OpVectorShuffle %44 %44 2 2 2 2 
					                                f32_4 %46 = OpFMul %43 %45 
					                                f32_4 %47 = OpLoad %15 
					                                f32_4 %48 = OpFAdd %46 %47 
					                                              OpStore %15 %48 
					                                f32_4 %49 = OpLoad %15 
					                       Uniform f32_4* %51 = OpAccessChain %26 %28 %50 
					                                f32_4 %52 = OpLoad %51 
					                                f32_4 %53 = OpFAdd %49 %52 
					                                              OpStore %15 %53 
					                                f32_4 %55 = OpLoad %15 
					                                f32_4 %56 = OpVectorShuffle %55 %55 1 1 1 1 
					                       Uniform f32_4* %57 = OpAccessChain %26 %29 %29 
					                                f32_4 %58 = OpLoad %57 
					                                f32_4 %59 = OpFMul %56 %58 
					                                              OpStore %54 %59 
					                       Uniform f32_4* %60 = OpAccessChain %26 %29 %28 
					                                f32_4 %61 = OpLoad %60 
					                                f32_4 %62 = OpLoad %15 
					                                f32_4 %63 = OpVectorShuffle %62 %62 0 0 0 0 
					                                f32_4 %64 = OpFMul %61 %63 
					                                f32_4 %65 = OpLoad %54 
					                                f32_4 %66 = OpFAdd %64 %65 
					                                              OpStore %54 %66 
					                       Uniform f32_4* %67 = OpAccessChain %26 %29 %41 
					                                f32_4 %68 = OpLoad %67 
					                                f32_4 %69 = OpLoad %15 
					                                f32_4 %70 = OpVectorShuffle %69 %69 2 2 2 2 
					                                f32_4 %71 = OpFMul %68 %70 
					                                f32_4 %72 = OpLoad %54 
					                                f32_4 %73 = OpFAdd %71 %72 
					                                              OpStore %54 %73 
					                       Uniform f32_4* %79 = OpAccessChain %26 %29 %50 
					                                f32_4 %80 = OpLoad %79 
					                                f32_4 %81 = OpLoad %15 
					                                f32_4 %82 = OpVectorShuffle %81 %81 3 3 3 3 
					                                f32_4 %83 = OpFMul %80 %82 
					                                f32_4 %84 = OpLoad %54 
					                                f32_4 %85 = OpFAdd %83 %84 
					                        Output f32_4* %87 = OpAccessChain %78 %28 
					                                              OpStore %87 %85 
					                                f32_4 %90 = OpLoad %89 
					                                              OpStore %88 %90 
					                          Output f32* %92 = OpAccessChain %78 %28 %74 
					                                  f32 %93 = OpLoad %92 
					                                  f32 %94 = OpFNegate %93 
					                          Output f32* %95 = OpAccessChain %78 %28 %74 
					                                              OpStore %95 %94 
					                                              OpReturn
					                                              OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 6
					; Bound: 162
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Fragment %4 "main" %26 %148 
					                                                     OpExecutionMode %4 OriginUpperLeft 
					                                                     OpName vs_TEXCOORD0 "vs_TEXCOORD0" 
					                                                     OpMemberDecorate %11 0 Offset 11 
					                                                     OpMemberDecorate %11 1 Offset 11 
					                                                     OpMemberDecorate %11 2 Offset 11 
					                                                     OpMemberDecorate %11 3 Offset 11 
					                                                     OpMemberDecorate %11 4 RelaxedPrecision 
					                                                     OpMemberDecorate %11 4 Offset 11 
					                                                     OpDecorate %11 Block 
					                                                     OpDecorate %13 DescriptorSet 13 
					                                                     OpDecorate %13 Binding 13 
					                                                     OpDecorate vs_TEXCOORD0 Location 26 
					                                                     OpDecorate %31 RelaxedPrecision 
					                                                     OpDecorate %32 RelaxedPrecision 
					                                                     OpDecorate %35 RelaxedPrecision 
					                                                     OpDecorate %36 RelaxedPrecision 
					                                                     OpDecorate %148 Location 148 
					                                                     OpDecorate %151 RelaxedPrecision 
					                                                     OpDecorate %151 DescriptorSet 151 
					                                                     OpDecorate %151 Binding 151 
					                                                     OpDecorate %152 RelaxedPrecision 
					                                                     OpDecorate %155 RelaxedPrecision 
					                                                     OpDecorate %155 DescriptorSet 155 
					                                                     OpDecorate %155 Binding 155 
					                                                     OpDecorate %156 RelaxedPrecision 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 2 
					                                              %8 = OpTypePointer Private %7 
					                               Private f32_2* %9 = OpVariable Private 
					                                             %10 = OpTypeVector %6 4 
					                                             %11 = OpTypeStruct %6 %6 %6 %6 %10 
					                                             %12 = OpTypePointer Uniform %11 
					Uniform struct {f32; f32; f32; f32; f32_4;}* %13 = OpVariable Uniform 
					                                             %14 = OpTypeInt 32 1 
					                                         i32 %15 = OpConstant 0 
					                                             %16 = OpTypePointer Uniform %6 
					                                             %20 = OpTypeInt 32 0 
					                                         u32 %21 = OpConstant 0 
					                                             %22 = OpTypePointer Private %6 
					                              Private f32_2* %24 = OpVariable Private 
					                                             %25 = OpTypePointer Input %7 
					                       Input f32_2* vs_TEXCOORD0 = OpVariable Input 
					                                         i32 %28 = OpConstant 4 
					                                             %29 = OpTypePointer Uniform %10 
					                                         i32 %39 = OpConstant 1 
					                                         i32 %42 = OpConstant 2 
					                                Private f32* %48 = OpVariable Private 
					                              Private f32_2* %54 = OpVariable Private 
					                                         i32 %55 = OpConstant 3 
					                                         f32 %58 = OpConstant 3,674022E-40 
					                                Private f32* %64 = OpVariable Private 
					                                             %73 = OpTypeBool 
					                                             %74 = OpTypePointer Private %73 
					                               Private bool* %75 = OpVariable Private 
					                                         f32 %93 = OpConstant 3,674022E-40 
					                                            %104 = OpTypeVector %6 3 
					                                            %105 = OpTypePointer Private %104 
					                             Private f32_3* %106 = OpVariable Private 
					                                        u32 %113 = OpConstant 1 
					                                        u32 %117 = OpConstant 2 
					                                            %132 = OpTypePointer Function %7 
					                                            %147 = OpTypePointer Output %10 
					                              Output f32_4* %148 = OpVariable Output 
					                                            %149 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                            %150 = OpTypePointer UniformConstant %149 
					       UniformConstant read_only Texture2D* %151 = OpVariable UniformConstant 
					                                            %153 = OpTypeSampler 
					                                            %154 = OpTypePointer UniformConstant %153 
					                   UniformConstant sampler* %155 = OpVariable UniformConstant 
					                                            %157 = OpTypeSampledImage %149 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                            Function f32_2* %133 = OpVariable Function 
					                                Uniform f32* %17 = OpAccessChain %13 %15 
					                                         f32 %18 = OpLoad %17 
					                                         f32 %19 = OpExtInst %1 13 %18 
					                                Private f32* %23 = OpAccessChain %9 %21 
					                                                     OpStore %23 %19 
					                                       f32_2 %27 = OpLoad vs_TEXCOORD0 
					                              Uniform f32_4* %30 = OpAccessChain %13 %28 
					                                       f32_4 %31 = OpLoad %30 
					                                       f32_2 %32 = OpVectorShuffle %31 %31 0 1 
					                                       f32_2 %33 = OpFMul %27 %32 
					                              Uniform f32_4* %34 = OpAccessChain %13 %28 
					                                       f32_4 %35 = OpLoad %34 
					                                       f32_2 %36 = OpVectorShuffle %35 %35 2 3 
					                                       f32_2 %37 = OpFAdd %33 %36 
					                                                     OpStore %24 %37 
					                                       f32_2 %38 = OpLoad %24 
					                                Uniform f32* %40 = OpAccessChain %13 %39 
					                                         f32 %41 = OpLoad %40 
					                                Uniform f32* %43 = OpAccessChain %13 %42 
					                                         f32 %44 = OpLoad %43 
					                                       f32_2 %45 = OpCompositeConstruct %41 %44 
					                                       f32_2 %46 = OpFNegate %45 
					                                       f32_2 %47 = OpFAdd %38 %46 
					                                                     OpStore %24 %47 
					                                       f32_2 %49 = OpLoad %24 
					                                       f32_2 %50 = OpLoad %24 
					                                         f32 %51 = OpDot %49 %50 
					                                                     OpStore %48 %51 
					                                         f32 %52 = OpLoad %48 
					                                         f32 %53 = OpExtInst %1 31 %52 
					                                                     OpStore %48 %53 
					                                Uniform f32* %56 = OpAccessChain %13 %55 
					                                         f32 %57 = OpLoad %56 
					                                         f32 %59 = OpFMul %57 %58 
					                                         f32 %60 = OpLoad %48 
					                                         f32 %61 = OpFNegate %60 
					                                         f32 %62 = OpFAdd %59 %61 
					                                Private f32* %63 = OpAccessChain %54 %21 
					                                                     OpStore %63 %62 
					                                Uniform f32* %65 = OpAccessChain %13 %55 
					                                         f32 %66 = OpLoad %65 
					                                         f32 %67 = OpFMul %66 %58 
					                                                     OpStore %64 %67 
					                                Private f32* %68 = OpAccessChain %54 %21 
					                                         f32 %69 = OpLoad %68 
					                                         f32 %70 = OpLoad %64 
					                                         f32 %71 = OpFDiv %69 %70 
					                                Private f32* %72 = OpAccessChain %54 %21 
					                                                     OpStore %72 %71 
					                                         f32 %76 = OpLoad %48 
					                                         f32 %77 = OpLoad %64 
					                                        bool %78 = OpFOrdLessThan %76 %77 
					                                                     OpStore %75 %78 
					                                Private f32* %79 = OpAccessChain %54 %21 
					                                         f32 %80 = OpLoad %79 
					                                Private f32* %81 = OpAccessChain %54 %21 
					                                         f32 %82 = OpLoad %81 
					                                         f32 %83 = OpFMul %80 %82 
					                                Private f32* %84 = OpAccessChain %54 %21 
					                                                     OpStore %84 %83 
					                                Private f32* %85 = OpAccessChain %9 %21 
					                                         f32 %86 = OpLoad %85 
					                                Private f32* %87 = OpAccessChain %54 %21 
					                                         f32 %88 = OpLoad %87 
					                                         f32 %89 = OpFMul %86 %88 
					                                Private f32* %90 = OpAccessChain %9 %21 
					                                                     OpStore %90 %89 
					                                Private f32* %91 = OpAccessChain %9 %21 
					                                         f32 %92 = OpLoad %91 
					                                         f32 %94 = OpFMul %92 %93 
					                                Private f32* %95 = OpAccessChain %9 %21 
					                                                     OpStore %95 %94 
					                                Private f32* %96 = OpAccessChain %9 %21 
					                                         f32 %97 = OpLoad %96 
					                                         f32 %98 = OpExtInst %1 14 %97 
					                                Private f32* %99 = OpAccessChain %54 %21 
					                                                     OpStore %99 %98 
					                               Private f32* %100 = OpAccessChain %9 %21 
					                                        f32 %101 = OpLoad %100 
					                                        f32 %102 = OpExtInst %1 13 %101 
					                               Private f32* %103 = OpAccessChain %9 %21 
					                                                     OpStore %103 %102 
					                               Private f32* %107 = OpAccessChain %9 %21 
					                                        f32 %108 = OpLoad %107 
					                                        f32 %109 = OpFNegate %108 
					                               Private f32* %110 = OpAccessChain %106 %21 
					                                                     OpStore %110 %109 
					                               Private f32* %111 = OpAccessChain %54 %21 
					                                        f32 %112 = OpLoad %111 
					                               Private f32* %114 = OpAccessChain %106 %113 
					                                                     OpStore %114 %112 
					                               Private f32* %115 = OpAccessChain %9 %21 
					                                        f32 %116 = OpLoad %115 
					                               Private f32* %118 = OpAccessChain %106 %117 
					                                                     OpStore %118 %116 
					                                      f32_2 %119 = OpLoad %24 
					                                      f32_2 %120 = OpVectorShuffle %119 %119 1 0 
					                                      f32_3 %121 = OpLoad %106 
					                                      f32_2 %122 = OpVectorShuffle %121 %121 1 2 
					                                        f32 %123 = OpDot %120 %122 
					                               Private f32* %124 = OpAccessChain %54 %113 
					                                                     OpStore %124 %123 
					                                      f32_2 %125 = OpLoad %24 
					                                      f32_2 %126 = OpVectorShuffle %125 %125 1 0 
					                                      f32_3 %127 = OpLoad %106 
					                                      f32_2 %128 = OpVectorShuffle %127 %127 0 1 
					                                        f32 %129 = OpDot %126 %128 
					                               Private f32* %130 = OpAccessChain %54 %21 
					                                                     OpStore %130 %129 
					                                       bool %131 = OpLoad %75 
					                                                     OpSelectionMerge %135 None 
					                                                     OpBranchConditional %131 %134 %137 
					                                            %134 = OpLabel 
					                                      f32_2 %136 = OpLoad %54 
					                                                     OpStore %133 %136 
					                                                     OpBranch %135 
					                                            %137 = OpLabel 
					                                      f32_2 %138 = OpLoad %24 
					                                                     OpStore %133 %138 
					                                                     OpBranch %135 
					                                            %135 = OpLabel 
					                                      f32_2 %139 = OpLoad %133 
					                                                     OpStore %9 %139 
					                                      f32_2 %140 = OpLoad %9 
					                               Uniform f32* %141 = OpAccessChain %13 %39 
					                                        f32 %142 = OpLoad %141 
					                               Uniform f32* %143 = OpAccessChain %13 %42 
					                                        f32 %144 = OpLoad %143 
					                                      f32_2 %145 = OpCompositeConstruct %142 %144 
					                                      f32_2 %146 = OpFAdd %140 %145 
					                                                     OpStore %9 %146 
					                        read_only Texture2D %152 = OpLoad %151 
					                                    sampler %156 = OpLoad %155 
					                 read_only Texture2DSampled %158 = OpSampledImage %152 %156 
					                                      f32_2 %159 = OpLoad %9 
					                                      f32_4 %160 = OpImageSampleImplicitLod %158 %159 
					                                                     OpStore %148 %160 
					                                                     OpReturn
					                                                     OpFunctionEnd"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"!!ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _Distortion;
						vec4 unused_0_2;
						float _CenterX;
						float _CenterY;
						float _Size;
						vec4 _MainTex_ST;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec2 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					float u_xlat4;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = sin(_Distortion);
					    u_xlat3.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat3.xy = u_xlat3.xy + (-vec2(_CenterX, _CenterY));
					    u_xlat9 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat1.x = _Size * 0.5 + (-u_xlat9);
					    u_xlat4 = _Size * 0.5;
					    u_xlat1.x = u_xlat1.x / u_xlat4;
					    u_xlatb9 = u_xlat9<u_xlat4;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * 16.0;
					    u_xlat1.x = cos(u_xlat0.x);
					    u_xlat0.x = sin(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.x);
					    u_xlat2.y = u_xlat1.x;
					    u_xlat2.z = u_xlat0.x;
					    u_xlat1.y = dot(u_xlat3.yx, u_xlat2.yz);
					    u_xlat1.x = dot(u_xlat3.yx, u_xlat2.xy);
					    u_xlat0.xy = (bool(u_xlatb9)) ? u_xlat1.xy : u_xlat3.xy;
					    u_xlat0.xy = u_xlat0.xy + vec2(_CenterX, _CenterY);
					    SV_Target0 = texture(_MainTex, u_xlat0.xy);
					    return;
					}"
				}
				SubProgram "glcore " {
					"!!!!GL3x"
				}
				SubProgram "vulkan " {
					"!!vulkan"
				}
			}
		}
	}
}