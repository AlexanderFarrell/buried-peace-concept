//
//  SkeletalShaderNorm.metal
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/20/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct VertexInPosNorBoneTex{
    packed_float3 position; //[[attribute(0)]];
    packed_float3 normal; //[[attribute(1)]];
    packed_float2 textureCoordinate; //[[attribute(2)]];
    packed_int4 boneIndices;
    packed_float4 boneWeights;
};

struct VertexOutPosNorBoneTex{
    float4 position [[position]];
    float3 normal;
    float2 textureCoordinate;
};

struct TransformMVP {
    float4x4 mvp_matrix;
};

struct ModelMatrices {
    TransformMVP matrixData[20];
};

struct NormalMatrices {
    float4x4 matrixData[20];
};

/* VERTEX POSITION COLOR TEXTURE GPU PROGRAMS */

vertex VertexOutPosNorBoneTex basic_vertexUvpntb(device VertexInPosNorBoneTex* vertex_array [[buffer(0)]],
                                            constant ModelMatrices& transform [[buffer(1)]],
                                            unsigned int vid [[vertex_id]]) {
    VertexInPosNorBoneTex VertexIn = vertex_array[vid];
    
    VertexOutPosNorBoneTex VertexOut;
    
    float4 posFourDimensional = float4(VertexIn.position, 1);
    
    float4 pos1 = transform.matrixData[VertexIn.boneIndices[0]].mvp_matrix * posFourDimensional;//float4(VertexIn.position[0], VertexIn.position[1], VertexIn.position[2], 1.0);//posFourDimensional;//transform.matrixData[0/*VertexIn.boneIndices[0]*/] * posFourDimensional;
    float4 pos2 = transform.matrixData[VertexIn.boneIndices[1]].mvp_matrix * posFourDimensional;
    float4 pos3 = transform.matrixData[VertexIn.boneIndices[2]].mvp_matrix * posFourDimensional;
    float4 pos4 = transform.matrixData[VertexIn.boneIndices[3]].mvp_matrix * posFourDimensional;
    
    VertexOut.position = (pos1 * VertexIn.boneWeights[0]) + (pos2 * VertexIn.boneWeights[1]) + (pos3 * VertexIn.boneWeights[2]) + (pos4 * VertexIn.boneWeights[3]);
    VertexOut.normal = float3(VertexIn.normal);
    VertexOut.textureCoordinate = float2(VertexIn.textureCoordinate);
    
    return VertexOut;
}

//Perhaps we just do the same thing with the normal. Just like we transformed the mesh, we do the same for the normal.
fragment half4 basic_fragmentUvpntb(VertexOutPosNorBoneTex interpolated [[stage_in]], texture2d<half> texture [[texture(0)]], sampler textureSampler [[sampler(0)]], constant float4& ambientColor [[buffer(2)]], constant float4& directionalLightPosition[[buffer(3)]]) {
    half4 colorSample = texture.sample(textureSampler, interpolated.textureCoordinate.xy);
    
    //float nDotVP = max(dot(normalize(normal), lightPosition), 0.0);
    
    //do half if i can
    //half directionalLightStrength = max(normalize(float4(interpolated.normal, 1.0)) * directionalLightPosition), 0.0);
    //half directionalLightStrength = normalize(float4(interpolated.normal, 1.0)) * directionalLightPosition;
    half directionalLightStrength = saturate(dot(float4(interpolated.normal, 1.0), directionalLightPosition));
    
    half4 colorStrength = half4(ambientColor * directionalLightStrength);
    
    half4 outputColor = colorSample * colorStrength;
    
    return outputColor;
}
