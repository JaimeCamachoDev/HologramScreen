Shader "_MaxKill Studios/SciFiHoloScreen/SciFiHoloScreen Additive BuiltIn"
{
	Properties
	{
		[HDR] _FrameTintColor( "Frame Tint Color", Color ) = ( 1, 1, 1, 1 )
		[NoScaleOffset] _MainTex( "Frame Texture", 2D ) = "black" {}
		[HDR] _HologramTintColor( "Hologram Tint Color", Color ) = ( 1, 1, 1, 1 )
		[Toggle( _USERANDOMHOLOGRAMTINT_ON )] _UseRandomHologramTint( "Use Random Hologram Tint", Float ) = 0
		_RandomHologramTintBlend( "Random Hologram Tint  Blend", Range( 0, 1 ) ) = 1
		_RandomHologramTintIntensity( "Random Hologram Tint Intensity", Float ) = 1
		_RandomHologramSaturation( "Random Hologram Saturation", Float ) = 8
		[NoScaleOffset] _HologramMaskTexture( "Hologram Mask Texture", 2D ) = "black" {}
		[KeywordEnum( MatchObject,Independent )] _HologramScaleOption( "Hologram Scale Option", Float ) = 0		
		_HologramScale( "Hologram Scale", Float ) = 1
		_DepthMultiplier( "Depth Multiplier", Float ) = 1
		[HDR] _RChannelColor( "R Channel Color", Color ) = ( 1, 0, 0, 1 )
		_RChannelDepth( "R Channel Depth", Float ) = 0
		[HDR] _GChannelColor( "G Channel Color", Color ) = ( 0, 1, 0, 1 )
		_GChannelDepth( "G Channel Depth", Float ) = 0.1
		[HDR] _BChannelColor( "B Channel Color", Color ) = ( 0, 0, 1, 1 )
		_BChannelDepth( "B Channel Depth", Float ) = 0.3
		[Toggle] _UseAlphaChannel( "Use Alpha Channel", Float ) = 0
		[HDR] _AlphaChannelColor( "Alpha Channel Color", Color ) = ( 1, 1, 0, 1 )
		_AlphaChannelDepth( "Alpha Channel Depth", Float ) = 0
		[HDR] _BackdropColor( "Backdrop Color", Color ) = ( 1, 1, 1, 0 )
		[Toggle( _USERANDOMBACKDROPCOLOR_ON )] _UseRandomBackdropColor( "Use Random Backdrop Color", Float ) = 0
		_RandomBackdropColorIntensity( "Random Backdrop Color Intensity", Float ) = 1
		_RandomBackdropColorBlend( "Random Backdrop Color Blend", Range( 0, 1 ) ) = 1
		[Toggle( _RANDOMCOLORSWIZZLEMODE_ON )] _RandomColorSwizzleMode( "Random Color Swizzle Mode", Float ) = 0
		_BackdropColorIntensity( "Backdrop Color Intensity", Float ) = 1
		[NoScaleOffset] _BackdropTexture( "Backdrop Texture", 2D ) = "black" {}
		[KeywordEnum( MatchObject,Independent )] _BackdropScaleOption( "Backdrop Scale Option", Float ) = 0
		_BackdropTiling( "Backdrop Tiling", Float ) = 1
		_BackdropDepth( "Backdrop Depth", Float ) = 1
		[HDR] _BackdropFogColor( "Backdrop Fog Color", Color ) = ( 1, 0.3843137, 0, 1 )
		_BackdropFogDensity( "Backdrop Fog Density", Range( 0, 1 ) ) = 0.25
		_BackdropFogDensityRemapMin( "Backdrop Fog Density Remap Min", Range( 0, 1 ) ) = 0
		_BackdropFogDensityRemapMax( "Backdrop Fog Density Remap Max", Range( 0, 1 ) ) = 1
		[Toggle( _SPRITESHEETMODE_ON )] _SpriteSheetMode( "SpriteSheet Mode", Float ) = 0
		_Rows( "Rows", Float ) = 1
		_Columns( "Columns", Float ) = 1
		_SpriteSheetID( "SpriteSheet ID", Float ) = 1
		[Toggle( _USERANDOMSPRITESHEETID_ON )] _UseRandomSpriteSheetID( "Use Random Sprite Sheet ID", Float ) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "DisableBatching" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend One One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USERANDOMHOLOGRAMTINT_ON
		#pragma shader_feature_local _HOLOGRAMSCALEOPTION_MATCHOBJECT _HOLOGRAMSCALEOPTION_INDEPENDENT
		#pragma shader_feature_local _SPRITESHEETMODE_ON
		#pragma shader_feature_local _USERANDOMSPRITESHEETID_ON
		#pragma shader_feature_local _USERANDOMBACKDROPCOLOR_ON
		#pragma shader_feature_local _RANDOMCOLORSWIZZLEMODE_ON
		#pragma shader_feature_local _BACKDROPSCALEOPTION_MATCHOBJECT _BACKDROPSCALEOPTION_INDEPENDENT
		#define ASE_VERSION 19903
		#pragma surface surf Unlit keepalpha 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv2_texcoord2;
		};

		uniform float4 _HologramTintColor;
		uniform float _RandomHologramTintIntensity;
		uniform float _RandomHologramSaturation;
		uniform float _RandomHologramTintBlend;
		uniform float _Rows;
		uniform float _Columns;
		uniform float _HologramScale;
		uniform float _DepthMultiplier;
		uniform float _RChannelDepth;
		uniform sampler2D _HologramMaskTexture;
		uniform float _SpriteSheetID;
		uniform float4 _RChannelColor;
		uniform float _GChannelDepth;
		uniform float4 _GChannelColor;
		uniform float _BChannelDepth;
		uniform float4 _BChannelColor;
		uniform float _UseAlphaChannel;
		uniform float _AlphaChannelDepth;
		uniform float4 _AlphaChannelColor;
		uniform float4 _BackdropColor;
		uniform float _RandomBackdropColorIntensity;
		uniform float _RandomBackdropColorBlend;
		uniform float _BackdropDepth;
		uniform sampler2D _BackdropTexture;
		uniform float _BackdropTiling;
		uniform float _BackdropColorIntensity;
		uniform float4 _BackdropFogColor;
		uniform float _BackdropFogDensityRemapMin;
		uniform float _BackdropFogDensityRemapMax;
		uniform float _BackdropFogDensity;
		uniform float4 _FrameTintColor;
		uniform sampler2D _MainTex;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float3 ase_objectPosition = UNITY_MATRIX_M._m03_m13_m23;
			float3 _HashSeed = float3(12.9898,78.233,45.164);
			float dotResult588 = dot( ase_objectPosition , (_HashSeed).xyz );
			float temp_output_634_0 = ( sin( dotResult588 ) * 43758.55 );
			float dotResult589 = dot( ase_objectPosition , (_HashSeed).zxy );
			float dotResult590 = dot( ase_objectPosition , (_HashSeed).yzx );
			float3 appendResult682 = (float3(frac( temp_output_634_0 ) , frac( ( sin( dotResult589 ) * 43758.55 ) ) , frac( ( sin( dotResult590 ) * 43758.55 ) )));
			float3 temp_output_12_0_g1 = ( appendResult682 * _RandomHologramTintIntensity );
			float dotResult28_g1 = dot( float3( 0.2126729, 0.7151522, 0.072175 ) , temp_output_12_0_g1 );
			float3 temp_cast_0 = (dotResult28_g1).xxx;
			float temp_output_21_0_g1 = _RandomHologramSaturation;
			float3 lerpResult31_g1 = lerp( temp_cast_0 , temp_output_12_0_g1 , temp_output_21_0_g1);
			float4 lerpResult718 = lerp( _HologramTintColor , float4( lerpResult31_g1 , 0.0 ) , _RandomHologramTintBlend);
			#ifdef _USERANDOMHOLOGRAMTINT_ON
				float4 staticSwitch725 = lerpResult718;
			#else
				float4 staticSwitch725 = _HologramTintColor;
			#endif
			float2 _Vector2 = float2(1,1);
			float temp_output_471_0 = min( _Rows , _Columns );
			float2 appendResult484 = (float2(( _Rows / temp_output_471_0 ) , ( _Columns / temp_output_471_0 )));
			#ifdef _SPRITESHEETMODE_ON
				float2 staticSwitch738 = appendResult484;
			#else
				float2 staticSwitch738 = _Vector2;
			#endif
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float2 appendResult483 = (float2(ase_parentObjectScale.x , ase_parentObjectScale.y));
			float temp_output_487_0 = ( 1.0 / _HologramScale );
			float2 temp_output_494_0 = ( ( staticSwitch738 * appendResult483 ) * temp_output_487_0 );
			#if defined( _HOLOGRAMSCALEOPTION_MATCHOBJECT )
				float2 staticSwitch534 = i.uv_texcoord;
			#elif defined( _HOLOGRAMSCALEOPTION_INDEPENDENT )
				float2 staticSwitch534 = ( ( temp_output_494_0 * i.uv_texcoord ) + ( ( temp_output_494_0 * float2( -0.5,-0.5 ) ) + float2( 0.5,0.5 ) ) );
			#else
				float2 staticSwitch534 = i.uv_texcoord;
			#endif
			float3 ase_positionWS = i.worldPos;
			float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - ase_positionWS );
			float3 ase_viewDirWS = normalize( ase_viewVectorWS );
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_tangentWS = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_bitangentWS = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_worldToTangent = float3x3( ase_tangentWS, ase_bitangentWS, ase_normalWS );
			float3 worldToTangentDir482 = mul( ase_worldToTangent, ase_viewDirWS );
			float2 appendResult490 = (float2(worldToTangentDir482.x , worldToTangentDir482.y));
			float temp_output_469_0 = max( _Rows , _Columns );
			float2 appendResult479 = (float2(( temp_output_469_0 / _Rows ) , ( temp_output_469_0 / _Columns )));
			#ifdef _SPRITESHEETMODE_ON
				float2 staticSwitch739 = appendResult479;
			#else
				float2 staticSwitch739 = _Vector2;
			#endif
			#if defined( _HOLOGRAMSCALEOPTION_MATCHOBJECT )
				float2 staticSwitch481 = appendResult483;
			#elif defined( _HOLOGRAMSCALEOPTION_INDEPENDENT )
				float2 staticSwitch481 = staticSwitch739;
			#else
				float2 staticSwitch481 = appendResult483;
			#endif
			#if defined( _HOLOGRAMSCALEOPTION_MATCHOBJECT )
				float staticSwitch497 = _DepthMultiplier;
			#elif defined( _HOLOGRAMSCALEOPTION_INDEPENDENT )
				float staticSwitch497 = ( temp_output_487_0 * _DepthMultiplier );
			#else
				float staticSwitch497 = _DepthMultiplier;
			#endif
			float2 temp_output_506_0 = ( ( appendResult490 / ( worldToTangentDir482.z * staticSwitch481 ) ) * staticSwitch497 );
			float2 temp_output_530_0 = ( ( temp_output_506_0 * _RChannelDepth ) * float2( -1,-1 ) );
			float2 break677 = saturate( ceil( ( ( abs( ( ( staticSwitch534 + temp_output_530_0 ) + float2( -0.5,-0.5 ) ) ) * float2( -1,-1 ) ) + 0.5 ) ) );
			float2 temp_output_617_0 = ( staticSwitch534 + temp_output_530_0 );
			#ifdef _USERANDOMSPRITESHEETID_ON
				float staticSwitch598 = temp_output_634_0;
			#else
				float staticSwitch598 = ( _SpriteSheetID + -1.0 );
			#endif
			float temp_output_609_0 = ( _Rows * _Columns );
			// *** BEGIN Flipbook UV Animation vars ***
			// Total tiles of Flipbook Texture
			float fbtotaltiles630 = min( _Rows * _Columns, temp_output_609_0 + 1 );
			// Offsets for cols and rows of Flipbook Texture
			float fbcolsoffset630 = 1.0f / _Rows;
			float fbrowsoffset630 = 1.0f / _Columns;
			// Speed of animation
			float fbspeed630 = _Time[ 1 ] * 0.0;
			// UV Tiling (col and row offset)
			float2 fbtiling630 = float2(fbcolsoffset630, fbrowsoffset630);
			// UV Offset - calculate current tile linear index, and convert it to (X * coloffset, Y * rowoffset)
			// Calculate current tile linear index
			float fbcurrenttileindex630 = floor( fmod( fbspeed630 + staticSwitch598, fbtotaltiles630) );
			fbcurrenttileindex630 += ( fbcurrenttileindex630 < 0) ? fbtotaltiles630 : 0;
			// Obtain Offset X coordinate from current tile linear index
			float fblinearindextox630 = round ( fmod ( fbcurrenttileindex630, _Rows ) );
			// Multiply Offset X by coloffset
			float fboffsetx630 = fblinearindextox630 * fbcolsoffset630;
			// Obtain Offset Y coordinate from current tile linear index
			float fblinearindextoy630 = round( fmod( ( fbcurrenttileindex630 - fblinearindextox630 ) / _Rows, _Columns ) );
			// Reverse Y to get tiles from Top to Bottom
			fblinearindextoy630 = (int)(_Columns-1) - fblinearindextoy630;
			// Multiply Offset Y by rowoffset
			float fboffsety630 = fblinearindextoy630 * fbrowsoffset630;
			// UV Offset
			float2 fboffset630 = float2(fboffsetx630, fboffsety630);
			// Flipbook UV
			float2 fbuv630 = temp_output_617_0 * fbtiling630 + fboffset630;
			// *** END Flipbook UV Animation vars ***
			int flipbookFrame630 = ( ( int )fbcurrenttileindex630);
			#ifdef _SPRITESHEETMODE_ON
				float2 staticSwitch657 = fbuv630;
			#else
				float2 staticSwitch657 = temp_output_617_0;
			#endif
			float2 temp_output_531_0 = ( ( temp_output_506_0 * _GChannelDepth ) * float2( -1,-1 ) );
			float2 break678 = saturate( ceil( ( ( abs( ( ( staticSwitch534 + temp_output_531_0 ) + float2( -0.5,-0.5 ) ) ) * float2( -1,-1 ) ) + 0.5 ) ) );
			float2 temp_output_618_0 = ( staticSwitch534 + temp_output_531_0 );
			float fbtotaltiles631 = min( _Rows * _Columns, temp_output_609_0 + 1 );
			float fbcolsoffset631 = 1.0f / _Rows;
			float fbrowsoffset631 = 1.0f / _Columns;
			float fbspeed631 = _Time[ 1 ] * 0.0;
			float2 fbtiling631 = float2(fbcolsoffset631, fbrowsoffset631);
			float fbcurrenttileindex631 = floor( fmod( fbspeed631 + staticSwitch598, fbtotaltiles631) );
			fbcurrenttileindex631 += ( fbcurrenttileindex631 < 0) ? fbtotaltiles631 : 0;
			float fblinearindextox631 = round ( fmod ( fbcurrenttileindex631, _Rows ) );
			float fboffsetx631 = fblinearindextox631 * fbcolsoffset631;
			float fblinearindextoy631 = round( fmod( ( fbcurrenttileindex631 - fblinearindextox631 ) / _Rows, _Columns ) );
			fblinearindextoy631 = (int)(_Columns-1) - fblinearindextoy631;
			float fboffsety631 = fblinearindextoy631 * fbrowsoffset631;
			float2 fboffset631 = float2(fboffsetx631, fboffsety631);
			float2 fbuv631 = temp_output_618_0 * fbtiling631 + fboffset631;
			int flipbookFrame631 = ( ( int )fbcurrenttileindex631);
			#ifdef _SPRITESHEETMODE_ON
				float2 staticSwitch653 = fbuv631;
			#else
				float2 staticSwitch653 = temp_output_618_0;
			#endif
			float2 temp_output_532_0 = ( ( temp_output_506_0 * _BChannelDepth ) * float2( -1,-1 ) );
			float2 break679 = saturate( ceil( ( ( abs( ( ( staticSwitch534 + temp_output_532_0 ) + float2( -0.5,-0.5 ) ) ) * float2( -1,-1 ) ) + 0.5 ) ) );
			float2 temp_output_619_0 = ( staticSwitch534 + temp_output_532_0 );
			float fbtotaltiles633 = min( _Rows * _Columns, temp_output_609_0 + 1 );
			float fbcolsoffset633 = 1.0f / _Rows;
			float fbrowsoffset633 = 1.0f / _Columns;
			float fbspeed633 = _Time[ 1 ] * 0.0;
			float2 fbtiling633 = float2(fbcolsoffset633, fbrowsoffset633);
			float fbcurrenttileindex633 = floor( fmod( fbspeed633 + staticSwitch598, fbtotaltiles633) );
			fbcurrenttileindex633 += ( fbcurrenttileindex633 < 0) ? fbtotaltiles633 : 0;
			float fblinearindextox633 = round ( fmod ( fbcurrenttileindex633, _Rows ) );
			float fboffsetx633 = fblinearindextox633 * fbcolsoffset633;
			float fblinearindextoy633 = round( fmod( ( fbcurrenttileindex633 - fblinearindextox633 ) / _Rows, _Columns ) );
			fblinearindextoy633 = (int)(_Columns-1) - fblinearindextoy633;
			float fboffsety633 = fblinearindextoy633 * fbrowsoffset633;
			float2 fboffset633 = float2(fboffsetx633, fboffsety633);
			float2 fbuv633 = temp_output_619_0 * fbtiling633 + fboffset633;
			int flipbookFrame633 = ( ( int )fbcurrenttileindex633);
			#ifdef _SPRITESHEETMODE_ON
				float2 staticSwitch648 = fbuv633;
			#else
				float2 staticSwitch648 = temp_output_619_0;
			#endif
			float2 temp_output_519_0 = ( ( temp_output_506_0 * _AlphaChannelDepth ) * float2( -1,-1 ) );
			float2 break652 = saturate( ceil( ( ( abs( ( ( staticSwitch534 + temp_output_519_0 ) + float2( -0.5,-0.5 ) ) ) * float2( -1,-1 ) ) + 0.5 ) ) );
			float2 temp_output_597_0 = ( staticSwitch534 + temp_output_519_0 );
			float fbtotaltiles608 = min( _Rows * _Columns, temp_output_609_0 + 1 );
			float fbcolsoffset608 = 1.0f / _Rows;
			float fbrowsoffset608 = 1.0f / _Columns;
			float fbspeed608 = _Time[ 1 ] * 0.0;
			float2 fbtiling608 = float2(fbcolsoffset608, fbrowsoffset608);
			float fbcurrenttileindex608 = floor( fmod( fbspeed608 + staticSwitch598, fbtotaltiles608) );
			fbcurrenttileindex608 += ( fbcurrenttileindex608 < 0) ? fbtotaltiles608 : 0;
			float fblinearindextox608 = round ( fmod ( fbcurrenttileindex608, _Rows ) );
			float fboffsetx608 = fblinearindextox608 * fbcolsoffset608;
			float fblinearindextoy608 = round( fmod( ( fbcurrenttileindex608 - fblinearindextox608 ) / _Rows, _Columns ) );
			fblinearindextoy608 = (int)(_Columns-1) - fblinearindextoy608;
			float fboffsety608 = fblinearindextoy608 * fbrowsoffset608;
			float2 fboffset608 = float2(fboffsetx608, fboffsety608);
			float2 fbuv608 = temp_output_597_0 * fbtiling608 + fboffset608;
			int flipbookFrame608 = ( ( int )fbcurrenttileindex608);
			#ifdef _SPRITESHEETMODE_ON
				float2 staticSwitch625 = fbuv608;
			#else
				float2 staticSwitch625 = temp_output_597_0;
			#endif
			float3 temp_output_662_0 = ( appendResult682 * _RandomBackdropColorIntensity );
			#ifdef _RANDOMCOLORSWIZZLEMODE_ON
				float3 staticSwitch698 = (temp_output_662_0).zxy;
			#else
				float3 staticSwitch698 = temp_output_662_0;
			#endif
			float4 lerpResult708 = lerp( _BackdropColor , float4( staticSwitch698 , 0.0 ) , _RandomBackdropColorBlend);
			#ifdef _USERANDOMBACKDROPCOLOR_ON
				float4 staticSwitch720 = lerpResult708;
			#else
				float4 staticSwitch720 = _BackdropColor;
			#endif
			float temp_output_503_0 = max( _BackdropDepth , 0.0001 );
			float3 appendResult526 = (float3(1.0 , 1.0 , ( 1.0 / temp_output_503_0 )));
			float2 uv2_TexCoord521 = i.uv2_texcoord2 + float2( -0.5,-0.5 );
			float3 _Vector0 = float3(-0.5,-0.5,0);
			float3 temp_output_524_0 = ( float3( uv2_TexCoord521 ,  0.0 ) - _Vector0 );
			float3 worldToObj492 = mul( unity_WorldToObject, float4( _WorldSpaceCameraPos, 1 ) ).xyz;
			float3 V2512 = ( worldToObj492 - _Vector0 );
			float3 V1537 = ( temp_output_524_0 - V2512 );
			float3 temp_output_614_0 = ( ( ( ( floor( ( appendResult526 * temp_output_524_0 ) ) + step( float3( 0,0,0 ) , V1537 ) ) / appendResult526 ) - V2512 ) / V1537 );
			float Y661 = (temp_output_614_0).y;
			float Z615 = (temp_output_614_0).z;
			float X616 = (temp_output_614_0).x;
			float temp_output_670_0 = step( Z615 , X616 );
			float ifLocalVar688 = 0;
			if( temp_output_670_0 <= 0.0 )
				ifLocalVar688 = X616;
			else
				ifLocalVar688 = Z615;
			#if defined( _BACKDROPSCALEOPTION_MATCHOBJECT )
				float2 staticSwitch520 = float2( 1,1 );
			#elif defined( _BACKDROPSCALEOPTION_INDEPENDENT )
				float2 staticSwitch520 = appendResult483;
			#else
				float2 staticSwitch520 = float2( 1,1 );
			#endif
			float2 break529 = staticSwitch520;
			float2 appendResult542 = (float2(break529.x , break529.y));
			float2 break581 = ( (( ( Z615 * V1537 ) + V2512 )).xy * ( _BackdropTiling * appendResult542 ) );
			float2 appendResult603 = (float2(break581.x , break581.y));
			float4 WallVar646 = tex2D( _BackdropTexture, appendResult603 );
			float2 temp_output_579_0 = (( ( X616 * V1537 ) + V2512 )).zy;
			float2 appendResult565 = (float2(1.0 , break529.y));
			float4 BackVar645 = tex2D( _BackdropTexture, ( temp_output_579_0 * ( _BackdropTiling * appendResult565 ) ) );
			float4 ifLocalVar689 = 0;
			if( temp_output_670_0 <= 0.0 )
				ifLocalVar689 = BackVar645;
			else
				ifLocalVar689 = WallVar646;
			float2 temp_output_599_0 = (( ( Y661 * V1537 ) + V2512 )).xz;
			float2 appendResult580 = (float2(break529.x , 1.0));
			float4 CeilVar669 = tex2D( _BackdropTexture, ( temp_output_599_0 * ( appendResult580 * _BackdropTiling ) ) );
			float4 ifLocalVar703 = 0;
			if( Y661 <= ifLocalVar688 )
				ifLocalVar703 = CeilVar669;
			else
				ifLocalVar703 = ifLocalVar689;
			#ifdef _USERANDOMBACKDROPCOLOR_ON
				float4 staticSwitch724 = lerpResult708;
			#else
				float4 staticSwitch724 = _BackdropFogColor;
			#endif
			float4 lerpResult727 = lerp( ( staticSwitch720 * ( ifLocalVar703 * _BackdropColorIntensity ) ) , staticSwitch724 , ( saturate( ( ( ( min( temp_output_599_0.y , temp_output_579_0.x ) / temp_output_503_0 ) - _BackdropFogDensityRemapMin ) / ( _BackdropFogDensityRemapMax - _BackdropFogDensityRemapMin ) ) ) * _BackdropFogDensity ));
			float2 uv_MainTex728 = i.uv_texcoord;
			float4 tex2DNode728 = tex2D( _MainTex, uv_MainTex728 );
			float4 lerpResult737 = lerp( ( ( staticSwitch725 * ( ( ( ( break677.x * break677.y ) * ( tex2D( _HologramMaskTexture, staticSwitch657 ).r * ( _RChannelColor * _RChannelColor.a ) ) ) + ( ( break678.x * break678.y ) * ( tex2D( _HologramMaskTexture, staticSwitch653 ).g * ( _GChannelColor * _GChannelColor.a ) ) ) ) + ( ( ( break679.x * break679.y ) * ( tex2D( _HologramMaskTexture, staticSwitch648 ).b * ( _BChannelColor * _BChannelColor.a ) ) ) + (( _UseAlphaChannel )?( ( ( break652.x * break652.y ) * ( tex2D( _HologramMaskTexture, staticSwitch625 ).a * ( _AlphaChannelColor * _AlphaChannelColor.a ) ) ) ):( float4( 0,0,0,0 ) )) ) ) ) + lerpResult727 ) , ( _FrameTintColor * tex2DNode728 ) , tex2DNode728.a);
			o.Emission = lerpResult737.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "MaxKillStudios_SciFiHoloScreenShaderGUI"
}
