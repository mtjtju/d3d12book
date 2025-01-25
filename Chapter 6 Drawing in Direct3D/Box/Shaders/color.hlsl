//***************************************************************************************
// color.hlsl by Frank Luna (C) 2015 All Rights Reserved.
//
// Transforms and colors geometry.
//***************************************************************************************

cbuffer cbPerObject : register(b0)
{
    float t;
	float4x4 gWorldViewProj; 
    float4 pulseColor;
};

struct VertexIn
{
    float4 Color : COLOR;
	float3 PosL  : POSITION;
};

struct VertexOut
{
	float4 PosH  : SV_POSITION;
    float4 Color : COLOR;
};

VertexOut VS(VertexIn vin, ColorIn cin)
{
	VertexOut vout;
	
	// Transform to homogeneous clip space.
	vout.PosH = mul(float4(vin.PosL, 1.0f), gWorldViewProj);
	
	// Just pass vertex color into the pixel shader.
    vout.Color = cin.Color;
    
    return vout;
}

float4 PS(VertexOut pin) : SV_Target
{
    //clip(-pin.Color.r + 0.5f);
    const float pi = 3.14159;
    float s = 0.5f * sin(2 * t - 0.25f * pi) + 0.5f;
    float4 c = lerp(pin.Color, pulseColor, s);
    return c;
}


