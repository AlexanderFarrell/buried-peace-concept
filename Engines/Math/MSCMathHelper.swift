//
//  MSCMathHelper.swift
//  SpelunkingSwift
//
//  Created by Alexander Farrell on 5/13/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

struct MSCPoint2 {
    var x: Double = 0.0
    var y: Double = 0.0
    
    func getTextReadout() -> String
    {
        return "X: " + String(x) + ", Y: " + String(y)
    }
    
    static func getMSCPointFromVector(vector: TDVector2) -> MSCPoint2
    {
        return MSCPoint2.init(x: Double(vector.v.0), y: Double(vector.v.1))
    }
}

struct MSCPoint3 {
    var x: Double = 0.0
    var y: Double = 0.0
    var z: Double = 0.0
    
    func getTextReadout() -> String
    {
        return "X: " + String(x) + ", Y: " + String(y) + ", Z: " + String(z)
    }
    
    static func getMSCPointFromVector(vector: TDVector3) -> MSCPoint3
    {
        return MSCPoint3.init(x: Double(vector.v.0), y: Double(vector.v.1), z: Double(vector.v.2))
    }
}


struct MSCQuadrilateral
{
    var topLeft: MSCPoint2
    var topRight: MSCPoint2
    var bottomLeft: MSCPoint2
    var bottomRight: MSCPoint2
    
    func getArea() -> Double
    {
        let triangleOne = MSCTriangle.init(pointOne: topLeft, pointTwo: topRight, pointThree: bottomLeft)
        let triangleTwo = MSCTriangle.init(pointOne: topRight, pointTwo: bottomLeft, pointThree: bottomRight)
        
        return triangleOne.getArea() + triangleTwo.getArea()
    }
    
    func isPointInside(point: MSCPoint2) -> Bool
    {
        return MSCMathHelper.IsPointInQuad(point: point, quad: self)
    }
}

struct MSCTriangle
{
    var pointOne: MSCPoint2
    var pointTwo: MSCPoint2
    var pointThree: MSCPoint2
    
    func getArea() -> Double
    {
        //Shoelace Formula for Triangle Area
        let calculation = (pointOne.x * pointTwo.y) + (pointTwo.x * pointThree.y) + (pointThree.x * pointOne.y) - (pointOne.x * pointThree.y) - (pointThree.x * pointTwo.y) - (pointTwo.x * pointOne.y)
        let absCalc = abs(calculation)
        let area = absCalc * 0.5
        
        return area
    }
    
    func getMidpoint() -> MSCPoint2
    {
        var xAverage = (pointOne.x + pointTwo.x + pointThree.x)/3.0
        var yAverage = (pointOne.y + pointTwo.y + pointThree.y)/3.0
        
        return MSCPoint2.init(x: xAverage, y: yAverage)
    }
    
    func getBarycentricCoordinates(point: MSCPoint2) -> MSCPoint3
    {
        let triangleOneArea = MSCTriangle.init(pointOne: pointTwo, pointTwo: pointThree, pointThree: point).getArea()
        let triangleTwoArea = MSCTriangle.init(pointOne: pointThree, pointTwo: pointOne, pointThree: point).getArea()
        let triangleThreeArea = MSCTriangle.init(pointOne: pointOne, pointTwo: pointTwo, pointThree: point).getArea()
        
        let totalArea = getArea()
        
        let retVal = MSCPoint3.init(x: triangleOneArea/totalArea, y: triangleTwoArea/totalArea, z: triangleThreeArea/totalArea)
        
        return retVal
    }
    
    func getCartesianCoordinates(barycentricPoint: MSCPoint3) -> MSCPoint2
    {
        let x = (barycentricPoint.x * pointOne.x) + (barycentricPoint.y * pointTwo.x) + (barycentricPoint.z * pointThree.x)
        let y = (barycentricPoint.x * pointOne.y) + (barycentricPoint.y * pointTwo.y) + (barycentricPoint.z * pointThree.y)
        
        let point = MSCPoint2.init(x: x, y: y)
        
        return point
    }
    
    func isPointInside(point: MSCPoint2) -> Bool
    {
        return MSCMathHelper.IsPointInTri(point: point, tri: self)
    }
}

struct MSCRange {
    var low: Double = 0.0
    var high: Double = 0.0
}

struct MSCCircle {
    var center: MSCPoint2 = MSCPoint2.init(x: 0.0, y: 0.0)
    var radius: Double = 0.0
}

struct MSCRectangle {
    var topLeft: MSCPoint2 = MSCPoint2.init(x: 0.0, y: 0.0)
    var bottomRight: MSCPoint2 = MSCPoint2.init(x: 0.0, y: 0.0)
    
    func getPoints() -> [MSCPoint2]
    {
        var retValPoints = [MSCPoint2]()
        
        retValPoints.append(MSCPoint2.init(x: topLeft.x, y: topLeft.y))
        retValPoints.append(MSCPoint2.init(x: topLeft.x, y: bottomRight.y))
        retValPoints.append(MSCPoint2.init(x: bottomRight.x, y: topLeft.y))
        retValPoints.append(MSCPoint2.init(x: bottomRight.x, y: bottomRight.y))
        
        return retValPoints
    }
    
    func getXRange() -> MSCRange
    {
        return MSCRange.init(low: topLeft.x, high: bottomRight.x)
    }
    
    func getYRange() -> MSCRange
    {
        return MSCRange.init(low: topLeft.y, high: bottomRight.y)
    }
    
    func splitByX(x: Double) -> [MSCRectangle]
    {
        var retValRectangles = [MSCRectangle]()
        
        if MSCMathHelper.isValueIntersectingRange(value: x, range: getXRange())
        {
            //TODO: FINISH AND DO SPLIT BY Y
        }
        else
        {
            let range = getXRange()
            print("Attempted split of rectangle at X: " + String(x) + ". This is out of range of the rectangle, which starts at X: " + String(range.low) + " and ends at X: " + String(range.high) + ". Returning the original rectangle only. ")
            
            retValRectangles.append(self)
        }
        
        return retValRectangles
    }
}

class MSCMathHelper: NSObject {
    class func matrix4ToArray(matrix: TDMatrix4) -> Array<Float> {
        var matrixData = Array<Float>()
        let matrix = matrix.m
        
        matrixData.append(matrix.0)
        matrixData.append(matrix.1)
        matrixData.append(matrix.2)
        matrixData.append(matrix.3)
        matrixData.append(matrix.4)
        matrixData.append(matrix.5)
        matrixData.append(matrix.6)
        matrixData.append(matrix.7)
        matrixData.append(matrix.8)
        matrixData.append(matrix.9)
        matrixData.append(matrix.10)
        matrixData.append(matrix.11)
        matrixData.append(matrix.12)
        matrixData.append(matrix.13)
        matrixData.append(matrix.14)
        matrixData.append(matrix.15)
        
        return matrixData
    }
    
    class func dataSizeOfArray(data: Array<Float>) -> Int {
        let dataSize = data.count * MemoryLayout.size(ofValue: data[0])
        
        return dataSize
    }
    
    class func lerpFloat(start: Float, end: Float, amo: Float) -> Float
    {
        return start + (amo * (end - start))
    }
    
    class func lerpDouble(start: Double, end: Double, amo: Double) -> Double
    {
        return start + (amo * (end - start))
    }
    
    class func clamp(amo: Double, min: Double, max: Double) -> Double
    {
        var retVal = (amo > max) ? max : amo
        retVal = (retVal < min) ? min : retVal
        
        return retVal
    }
    
    class func wrapInt(amo: Int, max: Int) -> Int
    {
        let amoToRemove = Int(floor(Double(amo)/Double(max)) * Double(max))
        
        let retVal = amo - amoToRemove
        
        return retVal
    }
    
    class func wrapDouble(amo: Double, max: Double ) -> Double
    {
        let amoToRemove = floor(Double(amo)/Double(max)) * Double(max)
        
        var retVal = amo - amoToRemove
        
        if retVal >= max
        {
            retVal -= max
        }
        
        return retVal
    }
    
    class func clampInt(amo: Int, min: Int, max: Int) -> Int
    {
        var retVal = (amo > max) ? max : amo
        retVal = (retVal < min) ? min : retVal
        
        if retVal >= max
        {
            retVal -= max
        }
        
        return retVal
    }
    
    class func SmoothInterpolation(linearAmo: Double) -> Double
    {
        let retValSmoothAmo = 1.0 - ((0.5 * cos((1.0 * Double.pi) * linearAmo)) + 0.5)
        
        return retValSmoothAmo
    }
    
    class func IsPointInQuad(point: MSCPoint2, quad: MSCQuadrilateral) -> Bool
    {
        let triangleOne = MSCTriangle.init(pointOne: quad.topLeft, pointTwo: quad.topRight, pointThree: point)
        let triangleTwo = MSCTriangle.init(pointOne: quad.topRight, pointTwo: quad.bottomRight, pointThree: point)
        let triangleThree = MSCTriangle.init(pointOne: quad.topLeft, pointTwo: quad.bottomLeft, pointThree: point)
        let triangleFour = MSCTriangle.init(pointOne: quad.bottomLeft, pointTwo: quad.bottomRight, pointThree: point)
        
        let areaTest = Float(triangleOne.getArea() + triangleTwo.getArea() + triangleThree.getArea() + triangleFour.getArea())
        
        let areaQuad = Float(quad.getArea())
        
        return (areaTest == areaQuad)
    }
    
    class func IsPointInTri(point: MSCPoint2, tri: MSCTriangle) -> Bool
    {
        let triangleOneArea = MSCTriangle.init(pointOne: tri.pointTwo, pointTwo: tri.pointThree, pointThree: point).getArea()
        let triangleTwoArea = MSCTriangle.init(pointOne: tri.pointThree, pointTwo: tri.pointOne, pointThree: point).getArea()
        let triangleThreeArea = MSCTriangle.init(pointOne: tri.pointOne, pointTwo: tri.pointTwo, pointThree: point).getArea()
        
        let totalArea = Float(tri.getArea())
        
        let totalTestArea = Float(triangleOneArea + triangleTwoArea + triangleThreeArea)
        
        return (totalTestArea == totalArea)
    }
    
    /*class func isQuadWithinQuad() -> Bool
    {
     //Support Longs and Doubles
     
     + (BOOL)isRangeWithinRangeFloatFirstRangeLow:(float)r1Low
        FirstRangeHigh:(float)r1High
        SecondRangeLow:(float)r2Low
        SecondRangeHigh:(float)r2High
        {
            BOOL retVal;
            
            int pointsInsideRangeOne = 0;
            int pointsInsideRangeTwo = 0;
            
            if (r1Low <= r2Low <= r1High) {
                pointsInsideRangeOne++;
            }
            
            if (r1Low <= r2High <= r1High) {
                pointsInsideRangeOne++;
            }
            
            if (r2Low <= r1Low <= r2High) {
                pointsInsideRangeTwo++;
            }
            
            if (r2Low <= r1High <= r2High) {
                pointsInsideRangeTwo++;
            }
            
            if (pointsInsideRangeOne > 0 || pointsInsideRangeTwo > 0) {
                retVal = true;
            }
            else
            {
                retVal = false;
            }
            
            return retVal;
        }
    }*/
    
    //MARK: - Geometric Collision
    
    class func isCircleIntersectingRectangle(circle: MSCCircle, rectangle: MSCRectangle) -> Bool
    {
        //Check if a rectangle point is in the circle
        
        for point in rectangle.getPoints() {
            if isPointInCircle(point: point, circle: circle) {
                return true
            }
        }
        
        //If not, check if the circle's center is in the point
        
        if isPointInRectangle(point: circle.center, rectangle: rectangle)
        {
            return true
        }
        
        //If not, then we check left, right, up and down corners of the circle. This can only be done with rectangles which are not rotated.
        
        if (isPointInRectangle(point: MSCPoint2.init(x: 0.0, y: circle.radius), rectangle: rectangle) ||
        isPointInRectangle(point: MSCPoint2.init(x: 0.0, y: -circle.radius), rectangle: rectangle) ||
        isPointInRectangle(point: MSCPoint2.init(x: circle.radius, y: 0.0), rectangle: rectangle) ||
        isPointInRectangle(point: MSCPoint2.init(x: -circle.radius, y: 0.0), rectangle: rectangle))
        {
            return true
        }
        
        return false
    }
    
    class func isRectangleIntersectingCircle(rectangle: MSCRectangle, circle: MSCCircle) -> Bool
    {
        return MSCMathHelper.isCircleIntersectingRectangle(circle: circle, rectangle: rectangle)
    }
    
    class func isCircleIntersectingCircle(circleOne: MSCCircle, circleTwo: MSCCircle) -> Bool
    {
        let distanceFromCenters = MSCMathHelper.distance(pointOne: circleOne.center, pointTwo: circleTwo.center)
        
        return (distanceFromCenters < (circleOne.radius + circleTwo.radius))
    }
    
    class func isRectangleIntersectingRectangle(rectangleOne: MSCRectangle, rectangleTwo: MSCRectangle) -> Bool
    {
        return ((isRangeIntersectingRange(rangeOne: rectangleOne.getXRange(), rangeTwo: rectangleTwo.getXRange())) && (isRangeIntersectingRange(rangeOne: rectangleOne.getYRange(), rangeTwo: rectangleTwo.getYRange())))
    }
    
    class func distance(pointOne: MSCPoint2, pointTwo: MSCPoint2) -> Double
    {
        return sqrt(pow(pointTwo.x - pointOne.x, 2) + pow(pointTwo.y - pointOne.y, 2))
    }
    
    class func isPointInCircle(point: MSCPoint2, circle: MSCCircle) -> Bool
    {
        let distance = MSCMathHelper.distance(pointOne: circle.center, pointTwo: point)
        
        //If the radius is larger than the distance, it returns true. Otherwise this returns false.
        return (distance < circle.radius)
    }
    
    class func isPointInRectangleArrayFriendly(point: MSCPoint2, rectangle: MSCRectangle) -> Bool
    {
        //If its within the bounds, it returns true. Otherwise this returns false
        return ((point.x >= rectangle.topLeft.x) && (point.x < rectangle.bottomRight.x) && (point.y >= rectangle.topLeft.y) && (point.y < rectangle.bottomRight.y))
    }
    
    class func isPointInRectangle(point: MSCPoint2, rectangle: MSCRectangle) -> Bool
    {
        //If its within the bounds, it returns true. Otherwise this returns false
        return ((point.x >= rectangle.topLeft.x) && (point.x <= rectangle.bottomRight.x) && (point.y >= rectangle.topLeft.y) && (point.y <= rectangle.bottomRight.y))
    }
    
    class func isValueIntersectingRange(value: Double, range: MSCRange) -> Bool
    {
        return ((value >= range.low) && (value <= range.high))
    }
    
    class func isValueIntersectingRangeArrayFriendly(value: Double, range: MSCRange) -> Bool
    {
        return ((value >= range.low) && (value < range.high))
    }
    
    class func isRangeIntersectingRange(rangeOne: MSCRange, rangeTwo: MSCRange) -> Bool
    {
        return (isValueIntersectingRange(value: rangeOne.low, range: rangeTwo) || isValueIntersectingRange(value: rangeOne.high, range: rangeTwo) || isValueIntersectingRange(value: rangeTwo.low, range: rangeOne) || isValueIntersectingRange(value: rangeTwo.high, range: rangeOne))
    }
    
    //MARK: - Geographical
    
    class func yawToCompassDirection(yaw: Double) -> String
    {
        let normalizedYaw = clamp(amo: yaw/Double.pi, min: 0.00000001, max: 0.999999999)
        
        let intValue = Int(floor(normalizedYaw * 8.0))
        
        switch intValue {
        case 0:
            return "North"
        case 1:
            return "North West"
        case 2:
            return "West"
        case 3:
            return "South West"
        case 4:
            return "South"
        case 5:
            return "South East"
        case 6:
            return "East"
        case 7:
            return "North East"
        default:
            return "Error"
        }
    }
    
    //MARK: - COORDINATE SYSTEMS
    
    //MARK: Cartesian to Polar
    
    class func cartesianToPolar(cartesianCoordinates: TDVector2) -> TDVector2
    {
        let retValPolar = TDVector2Make(cartesian2DToRadius(cartesianCoordinates: cartesianCoordinates), cartesian2DToAzimuth(cartesianCoordinates: cartesianCoordinates))
        return retValPolar
    }
    
    class func cartesian2DToRadius(cartesianCoordinates: TDVector2) -> Float
    {
        var retVal: Float = 0.0
        let x = cartesianCoordinates.v.0
        let y = cartesianCoordinates.v.1
        
        retVal = sqrtf(pow(x, 2) + pow(y, 2))
        
        return retVal
    }
    
    class func cartesian2DToAzimuth(cartesianCoordinates: TDVector2) -> Float
    {
        var retVal: Float = 0.0
        let x = cartesianCoordinates.v.0
        let y = cartesianCoordinates.v.1
        
        retVal = atan2f(y, x)
        
        return retVal
    }
    
    //MARK: Polar to Cartesian
    
    class func polarToCartesian(polarCoordinates: TDVector2) -> TDVector2
    {
        let retValCartesian = TDVector2Make(polarToX(polarCoordinates: polarCoordinates), polarToY(polarCoordinates: polarCoordinates))
        return retValCartesian
    }
    
    class func polarToX(polarCoordinates: TDVector2) -> Float
    {
        var retValX: Float = 0.0
        let radius = polarCoordinates.v.0
        let azimuth = polarCoordinates.v.1
        
        retValX = radius * cosf(azimuth)
        
        return retValX
    }
    
    class func polarToY(polarCoordinates: TDVector2) -> Float
    {
        var retValY: Float = 0.0
        let radius = polarCoordinates.v.0
        let azimuth = polarCoordinates.v.1
        
        retValY = radius * sinf(azimuth)
        
        return retValY
    }
    
    //MARK: Cartesian to Barycentric
    
    //MARK: Barycentric to Cartesian
    
    //MARK: Cartesian to Spherical
    class func cartesianToSpherical(cartesianCoordinates: TDVector3) -> TDVector3
    {
        let retValSpherical = TDVector3Make(cartesianToRadius(cartesianCoordinates: cartesianCoordinates), cartesianToInclination(cartesianCoordinates: cartesianCoordinates), cartesianToAzimuth(cartesianCoordinates: cartesianCoordinates))
        
        return retValSpherical
    }
    
    class func cartesianToRadius(cartesianCoordinates: TDVector3) -> Float
    {
        var retValRadius: Float = 0.0
        let x = cartesianCoordinates.v.0
        let y = cartesianCoordinates.v.1
        let z = cartesianCoordinates.v.2
        
        retValRadius = sqrtf(pow(x, 2) + pow(y, 2) + pow(z, 2))
        
        return retValRadius
    }
    
    class func cartesianToInclination(cartesianCoordinates: TDVector3) -> Float
    {
        var retValInclination: Float = 0.0
        let z = cartesianCoordinates.v.2
        
        retValInclination = acosf(z / cartesianToRadius(cartesianCoordinates: cartesianCoordinates))
        
        return retValInclination
    }
    
    class func cartesianToAzimuth(cartesianCoordinates: TDVector3) -> Float
    {
        var retValAzimuth: Float = 0.0
        let x = cartesianCoordinates.v.0
        let y = cartesianCoordinates.v.1
        
        //retValAzimuth = atanf(y / x)
        retValAzimuth = atan2f(y, x)
        
        return retValAzimuth
    }
    
    //MARK: Spherical to Cartesian
    
    class func sphericalToCartesian(sphericalCoordinates: TDVector3) -> TDVector3
    {
        let retValCartesian = TDVector3Make(sphericalToX(spherical: sphericalCoordinates), sphericalToY(spherical: sphericalCoordinates), sphericalToZ(spherical: sphericalCoordinates))
        
        return retValCartesian
    }
    
    class func sphericalToX(spherical: TDVector3) -> Float
    {
        var retValX: Float = 0.0
        let radius = spherical.v.0
        let inclination = spherical.v.1
        let azimuth = spherical.v.2
        
        retValX = radius * sinf(inclination) * cosf(azimuth)
        
        return retValX
    }
    
    class func sphericalToY(spherical: TDVector3) -> Float
    {
        var retValY: Float = 0.0
        let radius = spherical.v.0
        let inclination = spherical.v.1
        let azimuth = spherical.v.2
        
        retValY = radius * sinf(inclination) * sinf(azimuth)
        
        return retValY
    }
    
    class func sphericalToZ(spherical: TDVector3) -> Float
    {
        var retValZ: Float = 0.0
        let radius = spherical.v.0
        let inclination = spherical.v.1
        
        retValZ = radius * cosf(inclination)
        
        return retValZ
    }
}
