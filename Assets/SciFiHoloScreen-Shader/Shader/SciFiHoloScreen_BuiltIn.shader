Shader "_MaxKill Studios/SciFiHoloScreen/SciFiHoloScreen BuiltIn"
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
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "DisableBatching" = "True" "IsEmissive" = "true"  }
		Cull Back
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
			float dotResult550 = dot( ase_objectPosition , (_HashSeed).xyz );
			float temp_output_553_0 = ( sin( dotResult550 ) * 43758.55 );
			float dotResult564 = dot( ase_objectPosition , (_HashSeed).zxy );
			float dotResult565 = dot( ase_objectPosition , (_HashSeed).yzx );
			float3 appendResult572 = (float3(frac( temp_output_553_0 ) , frac( ( sin( dotResult564 ) * 43758.55 ) ) , frac( ( sin( dotResult565 ) * 43758.55 ) )));
			float3 temp_output_12_0_g1 = ( appendResult572 * _RandomHologramTintIntensity );
			float dotResult28_g1 = dot( float3( 0.2126729, 0.7151522, 0.072175 ) , temp_output_12_0_g1 );
			float3 temp_cast_0 = (dotResult28_g1).xxx;
			float temp_output_21_0_g1 = _RandomHologramSaturation;
			float3 lerpResult31_g1 = lerp( temp_cast_0 , temp_output_12_0_g1 , temp_output_21_0_g1);
			float4 lerpResult576 = lerp( _HologramTintColor , float4( lerpResult31_g1 , 0.0 ) , _RandomHologramTintBlend);
			#ifdef _USERANDOMHOLOGRAMTINT_ON
				float4 staticSwitch573 = lerpResult576;
			#else
				float4 staticSwitch573 = _HologramTintColor;
			#endif
			float2 _Vector2 = float2(1,1);
			float temp_output_595_0 = min( _Rows , _Columns );
			float2 appendResult598 = (float2(( _Rows / temp_output_595_0 ) , ( _Columns / temp_output_595_0 )));
			#ifdef _SPRITESHEETMODE_ON
				float2 staticSwitch611 = appendResult598;
			#else
				float2 staticSwitch611 = _Vector2;
			#endif
			float3 ase_parentObjectScale = (1.0/float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ));
			float2 appendResult71 = (float2(ase_parentObjectScale.x , ase_parentObjectScale.y));
			float temp_output_332_0 = ( 1.0 / _HologramScale );
			float2 temp_output_329_0 = ( ( staticSwitch611 * appendResult71 ) * temp_output_332_0 );
			#if defined( _HOLOGRAMSCALEOPTION_MATCHOBJECT )
				float2 staticSwitch325 = i.uv_texcoord;
			#elif defined( _HOLOGRAMSCALEOPTION_INDEPENDENT )
				float2 staticSwitch325 = ( ( temp_output_329_0 * i.uv_texcoord ) + ( ( temp_output_329_0 * float2( -0.5,-0.5 ) ) + float2( 0.5,0.5 ) ) );
			#else
				float2 staticSwitch325 = i.uv_texcoord;
			#endif
			float3 ase_positionWS = i.worldPos;
			float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - ase_positionWS );
			float3 ase_viewDirWS = normalize( ase_viewVectorWS );
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_tangentWS = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_bitangentWS = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_worldToTangent = float3x3( ase_tangentWS, ase_bitangentWS, ase_normalWS );
			float3 worldToTangentDir473 = mul( ase_worldToTangent, ase_viewDirWS );
			float2 appendResult279 = (float2(worldToTangentDir473.x , worldToTangentDir473.y));
			float temp_output_610_0 = max( _Rows , _Columns );
			float2 appendResult608 = (float2(( temp_output_610_0 / _Rows ) , ( temp_output_610_0 / _Columns )));
			#ifdef _SPRITESHEETMODE_ON
				float2 staticSwitch614 = appendResult608;
			#else
				float2 staticSwitch614 = _Vector2;
			#endif
			#if defined( _HOLOGRAMSCALEOPTION_MATCHOBJECT )
				float2 staticSwitch326 = appendResult71;
			#elif defined( _HOLOGRAMSCALEOPTION_INDEPENDENT )
				float2 staticSwitch326 = staticSwitch614;
			#else
				float2 staticSwitch326 = appendResult71;
			#endif
			#if defined( _HOLOGRAMSCALEOPTION_MATCHOBJECT )
				float staticSwitch334 = _DepthMultiplier;
			#elif defined( _HOLOGRAMSCALEOPTION_INDEPENDENT )
				float staticSwitch334 = ( temp_output_332_0 * _DepthMultiplier );
			#else
				float staticSwitch334 = _DepthMultiplier;
			#endif
			float2 temp_output_44_0 = ( ( appendResult279 / ( worldToTangentDir473.z * staticSwitch326 ) ) * staticSwitch334 );
			float2 temp_output_27_0 = ( ( temp_output_44_0 * _RChannelDepth ) * float2( -1,-1 ) );
			float2 break493 = saturate( ceil( ( ( abs( ( ( staticSwitch325 + temp_output_27_0 ) + float2( -0.5,-0.5 ) ) ) * float2( -1,-1 ) ) + 0.5 ) ) );
			float2 temp_output_20_0 = ( staticSwitch325 + temp_output_27_0 );
			#ifdef _USERANDOMSPRITESHEETID_ON
				float staticSwitch575 = temp_output_553_0;
			#else
				float staticSwitch575 = ( _SpriteSheetID + -1.0 );
			#endif
			float temp_output_481_0 = ( _Rows * _Columns );
			// *** BEGIN Flipbook UV Animation vars ***
			// Total tiles of Flipbook Texture
			float fbtotaltiles483 = min( _Rows * _Columns, temp_output_481_0 + 1 );
			// Offsets for cols and rows of Flipbook Texture
			float fbcolsoffset483 = 1.0f / _Rows;
			float fbrowsoffset483 = 1.0f / _Columns;
			// Speed of animation
			float fbspeed483 = _Time[ 1 ] * 0.0;
			// UV Tiling (col and row offset)
			float2 fbtiling483 = float2(fbcolsoffset483, fbrowsoffset483);
			// UV Offset - calculate current tile linear index, and convert it to (X * coloffset, Y * rowoffset)
			// Calculate current tile linear index
			float fbcurrenttileindex483 = floor( fmod( fbspeed483 + staticSwitch575, fbtotaltiles483) );
			fbcurrenttileindex483 += ( fbcurrenttileindex483 < 0) ? fbtotaltiles483 : 0;
			// Obtain Offset X coordinate from current tile linear index
			float fblinearindextox483 = round ( fmod ( fbcurrenttileindex483, _Rows ) );
			// Multiply Offset X by coloffset
			float fboffsetx483 = fblinearindextox483 * fbcolsoffset483;
			// Obtain Offset Y coordinate from current tile linear index
			float fblinearindextoy483 = round( fmod( ( fbcurrenttileindex483 - fblinearindextox483 ) / _Rows, _Columns ) );
			// Reverse Y to get tiles from Top to Bottom
			fblinearindextoy483 = (int)(_Columns-1) - fblinearindextoy483;
			// Multiply Offset Y by rowoffset
			float fboffsety483 = fblinearindextoy483 * fbrowsoffset483;
			// UV Offset
			float2 fboffset483 = float2(fboffsetx483, fboffsety483);
			// Flipbook UV
			float2 fbuv483 = temp_output_20_0 * fbtiling483 + fboffset483;
			// *** END Flipbook UV Animation vars ***
			int flipbookFrame483 = ( ( int )fbcurrenttileindex483);
			#ifdef _SPRITESHEETMODE_ON
				float2 staticSwitch488 = fbuv483;
			#else
				float2 staticSwitch488 = temp_output_20_0;
			#endif
			float2 temp_output_28_0 = ( ( temp_output_44_0 * _GChannelDepth ) * float2( -1,-1 ) );
			float2 break513 = saturate( ceil( ( ( abs( ( ( staticSwitch325 + temp_output_28_0 ) + float2( -0.5,-0.5 ) ) ) * float2( -1,-1 ) ) + 0.5 ) ) );
			float2 temp_output_19_0 = ( staticSwitch325 + temp_output_28_0 );
			float fbtotaltiles544 = min( _Rows * _Columns, temp_output_481_0 + 1 );
			float fbcolsoffset544 = 1.0f / _Rows;
			float fbrowsoffset544 = 1.0f / _Columns;
			float fbspeed544 = _Time[ 1 ] * 0.0;
			float2 fbtiling544 = float2(fbcolsoffset544, fbrowsoffset544);
			float fbcurrenttileindex544 = floor( fmod( fbspeed544 + staticSwitch575, fbtotaltiles544) );
			fbcurrenttileindex544 += ( fbcurrenttileindex544 < 0) ? fbtotaltiles544 : 0;
			float fblinearindextox544 = round ( fmod ( fbcurrenttileindex544, _Rows ) );
			float fboffsetx544 = fblinearindextox544 * fbcolsoffset544;
			float fblinearindextoy544 = round( fmod( ( fbcurrenttileindex544 - fblinearindextox544 ) / _Rows, _Columns ) );
			fblinearindextoy544 = (int)(_Columns-1) - fblinearindextoy544;
			float fboffsety544 = fblinearindextoy544 * fbrowsoffset544;
			float2 fboffset544 = float2(fboffsetx544, fboffsety544);
			float2 fbuv544 = temp_output_19_0 * fbtiling544 + fboffset544;
			int flipbookFrame544 = ( ( int )fbcurrenttileindex544);
			#ifdef _SPRITESHEETMODE_ON
				float2 staticSwitch541 = fbuv544;
			#else
				float2 staticSwitch541 = temp_output_19_0;
			#endif
			float2 temp_output_29_0 = ( ( temp_output_44_0 * _BChannelDepth ) * float2( -1,-1 ) );
			float2 break522 = saturate( ceil( ( ( abs( ( ( staticSwitch325 + temp_output_29_0 ) + float2( -0.5,-0.5 ) ) ) * float2( -1,-1 ) ) + 0.5 ) ) );
			float2 temp_output_16_0 = ( staticSwitch325 + temp_output_29_0 );
			float fbtotaltiles545 = min( _Rows * _Columns, temp_output_481_0 + 1 );
			float fbcolsoffset545 = 1.0f / _Rows;
			float fbrowsoffset545 = 1.0f / _Columns;
			float fbspeed545 = _Time[ 1 ] * 0.0;
			float2 fbtiling545 = float2(fbcolsoffset545, fbrowsoffset545);
			float fbcurrenttileindex545 = floor( fmod( fbspeed545 + staticSwitch575, fbtotaltiles545) );
			fbcurrenttileindex545 += ( fbcurrenttileindex545 < 0) ? fbtotaltiles545 : 0;
			float fblinearindextox545 = round ( fmod ( fbcurrenttileindex545, _Rows ) );
			float fboffsetx545 = fblinearindextox545 * fbcolsoffset545;
			float fblinearindextoy545 = round( fmod( ( fbcurrenttileindex545 - fblinearindextox545 ) / _Rows, _Columns ) );
			fblinearindextoy545 = (int)(_Columns-1) - fblinearindextoy545;
			float fboffsety545 = fblinearindextoy545 * fbrowsoffset545;
			float2 fboffset545 = float2(fboffsetx545, fboffsety545);
			float2 fbuv545 = temp_output_16_0 * fbtiling545 + fboffset545;
			int flipbookFrame545 = ( ( int )fbcurrenttileindex545);
			#ifdef _SPRITESHEETMODE_ON
				float2 staticSwitch542 = fbuv545;
			#else
				float2 staticSwitch542 = temp_output_16_0;
			#endif
			float2 temp_output_314_0 = ( ( temp_output_44_0 * _AlphaChannelDepth ) * float2( -1,-1 ) );
			float2 break530 = saturate( ceil( ( ( abs( ( ( staticSwitch325 + temp_output_314_0 ) + float2( -0.5,-0.5 ) ) ) * float2( -1,-1 ) ) + 0.5 ) ) );
			float2 temp_output_312_0 = ( staticSwitch325 + temp_output_314_0 );
			float fbtotaltiles546 = min( _Rows * _Columns, temp_output_481_0 + 1 );
			float fbcolsoffset546 = 1.0f / _Rows;
			float fbrowsoffset546 = 1.0f / _Columns;
			float fbspeed546 = _Time[ 1 ] * 0.0;
			float2 fbtiling546 = float2(fbcolsoffset546, fbrowsoffset546);
			float fbcurrenttileindex546 = floor( fmod( fbspeed546 + staticSwitch575, fbtotaltiles546) );
			fbcurrenttileindex546 += ( fbcurrenttileindex546 < 0) ? fbtotaltiles546 : 0;
			float fblinearindextox546 = round ( fmod ( fbcurrenttileindex546, _Rows ) );
			float fboffsetx546 = fblinearindextox546 * fbcolsoffset546;
			float fblinearindextoy546 = round( fmod( ( fbcurrenttileindex546 - fblinearindextox546 ) / _Rows, _Columns ) );
			fblinearindextoy546 = (int)(_Columns-1) - fblinearindextoy546;
			float fboffsety546 = fblinearindextoy546 * fbrowsoffset546;
			float2 fboffset546 = float2(fboffsetx546, fboffsety546);
			float2 fbuv546 = temp_output_312_0 * fbtiling546 + fboffset546;
			int flipbookFrame546 = ( ( int )fbcurrenttileindex546);
			#ifdef _SPRITESHEETMODE_ON
				float2 staticSwitch543 = fbuv546;
			#else
				float2 staticSwitch543 = temp_output_312_0;
			#endif
			float3 temp_output_581_0 = ( appendResult572 * _RandomBackdropColorIntensity );
			#ifdef _RANDOMCOLORSWIZZLEMODE_ON
				float3 staticSwitch587 = (temp_output_581_0).zxy;
			#else
				float3 staticSwitch587 = temp_output_581_0;
			#endif
			float4 lerpResult583 = lerp( _BackdropColor , float4( staticSwitch587 , 0.0 ) , _RandomBackdropColorBlend);
			#ifdef _USERANDOMBACKDROPCOLOR_ON
				float4 staticSwitch574 = lerpResult583;
			#else
				float4 staticSwitch574 = _BackdropColor;
			#endif
			float temp_output_275_0 = max( _BackdropDepth , 0.0001 );
			float3 appendResult273 = (float3(1.0 , 1.0 , ( 1.0 / temp_output_275_0 )));
			float2 uv2_TexCoord238 = i.uv2_texcoord2 + float2( -0.5,-0.5 );
			float3 _Vector0 = float3(-0.5,-0.5,0);
			float3 temp_output_107_0 = ( float3( uv2_TexCoord238 ,  0.0 ) - _Vector0 );
			float3 worldToObj229 = mul( unity_WorldToObject, float4( _WorldSpaceCameraPos, 1 ) ).xyz;
			float3 V2108 = ( worldToObj229 - _Vector0 );
			float3 V1113 = ( temp_output_107_0 - V2108 );
			float3 temp_output_122_0 = ( ( ( ( floor( ( appendResult273 * temp_output_107_0 ) ) + step( float3( 0,0,0 ) , V1113 ) ) / appendResult273 ) - V2108 ) / V1113 );
			float Y163 = (temp_output_122_0).y;
			float Z141 = (temp_output_122_0).z;
			float X157 = (temp_output_122_0).x;
			float temp_output_205_0 = step( Z141 , X157 );
			float ifLocalVar216 = 0;
			if( temp_output_205_0 <= 0.0 )
				ifLocalVar216 = X157;
			else
				ifLocalVar216 = Z141;
			#if defined( _BACKDROPSCALEOPTION_MATCHOBJECT )
				float2 staticSwitch409 = float2( 1,1 );
			#elif defined( _BACKDROPSCALEOPTION_INDEPENDENT )
				float2 staticSwitch409 = appendResult71;
			#else
				float2 staticSwitch409 = float2( 1,1 );
			#endif
			float2 break318 = staticSwitch409;
			float2 appendResult421 = (float2(break318.x , break318.y));
			float2 break167 = ( (( ( Z141 * V1113 ) + V2108 )).xy * ( _BackdropTiling * appendResult421 ) );
			float2 appendResult171 = (float2(break167.x , break167.y));
			float4 WallVar184 = tex2D( _BackdropTexture, appendResult171 );
			float2 temp_output_176_0 = (( ( X157 * V1113 ) + V2108 )).zy;
			float2 appendResult307 = (float2(1.0 , break318.y));
			float4 BackVar202 = tex2D( _BackdropTexture, ( temp_output_176_0 * ( _BackdropTiling * appendResult307 ) ) );
			float4 ifLocalVar211 = 0;
			if( temp_output_205_0 <= 0.0 )
				ifLocalVar211 = BackVar202;
			else
				ifLocalVar211 = WallVar184;
			float2 temp_output_195_0 = (( ( Y163 * V1113 ) + V2108 )).xz;
			float2 appendResult306 = (float2(break318.x , 1.0));
			float4 CeilVar213 = tex2D( _BackdropTexture, ( temp_output_195_0 * ( appendResult306 * _BackdropTiling ) ) );
			float4 ifLocalVar219 = 0;
			if( Y163 <= ifLocalVar216 )
				ifLocalVar219 = CeilVar213;
			else
				ifLocalVar219 = ifLocalVar211;
			#ifdef _USERANDOMBACKDROPCOLOR_ON
				float4 staticSwitch585 = lerpResult583;
			#else
				float4 staticSwitch585 = _BackdropFogColor;
			#endif
			float4 lerpResult301 = lerp( ( staticSwitch574 * ( ifLocalVar219 * _BackdropColorIntensity ) ) , staticSwitch585 , ( saturate( ( ( ( min( temp_output_195_0.y , temp_output_176_0.x ) / temp_output_275_0 ) - _BackdropFogDensityRemapMin ) / ( _BackdropFogDensityRemapMax - _BackdropFogDensityRemapMin ) ) ) * _BackdropFogDensity ));
			float2 uv_MainTex419 = i.uv_texcoord;
			float4 tex2DNode419 = tex2D( _MainTex, uv_MainTex419 );
			float4 lerpResult420 = lerp( ( ( staticSwitch573 * ( ( ( ( break493.x * break493.y ) * ( tex2D( _HologramMaskTexture, staticSwitch488 ).r * ( _RChannelColor * _RChannelColor.a ) ) ) + ( ( break513.x * break513.y ) * ( tex2D( _HologramMaskTexture, staticSwitch541 ).g * ( _GChannelColor * _GChannelColor.a ) ) ) ) + ( ( ( break522.x * break522.y ) * ( tex2D( _HologramMaskTexture, staticSwitch542 ).b * ( _BChannelColor * _BChannelColor.a ) ) ) + (( _UseAlphaChannel )?( ( ( break530.x * break530.y ) * ( tex2D( _HologramMaskTexture, staticSwitch543 ).a * ( _AlphaChannelColor * _AlphaChannelColor.a ) ) ) ):( float4( 0,0,0,0 ) )) ) ) ) + lerpResult301 ) , ( _FrameTintColor * tex2DNode419 ) , tex2DNode419.a);
			o.Emission = lerpResult420.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "MaxKillStudios_SciFiHoloScreenShaderGUI"
}