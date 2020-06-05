//
//  GraphView.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 28/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import SwiftUI


struct GraphView: Shape {
    var controlPoints: Vector
    var closedArea: Bool
    var originBottomLeft: Bool
    
    var animatableData: Vector {
        set { self.controlPoints = newValue }
        get { return self.controlPoints }
    }
    
    func point(index: Int, rect: CGRect) -> CGPoint {
        let value = self.controlPoints.values[index]
        let x = Double(index)/Double(self.controlPoints.values.count - 1 )*Double(rect.width)
        var y = Double(rect.height)*value
        
        if self.originBottomLeft {
            y = Double(rect.height) - y
        }
        
        return CGPoint(x: x, y: y)
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            let startPoint = self.point(index: 0, rect: rect)
            path.move(to: startPoint)
            
            var i = 1;
            while i < self.controlPoints.values.count {
                path.addLine(to:  self.point(index: i, rect: rect))
                i += 1;
            }
            
            if (self.closedArea) { // closed area below the chart line
                
                path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                path.addLine(to: CGPoint(x: 0, y: rect.height))
                path.addLine(to: startPoint)
            }
        }
    }
}



struct Vector: VectorArithmetic {
    
    var values: [Double] // vector values
    
    init(count: Int = 1) {
        self.values = [Double](repeating: 0.0, count: count)
        self.magnitudeSquared = 0.0
    }
    
    init(with values: [Double]) {
        self.values = values
        self.magnitudeSquared = 0
        self.recomputeMagnitude()
    }
    
    func computeMagnitude()->Double {
        // compute square magnitued of the vector
        // = sum of all squared values
        var sum: Double = 0.0
        
        for index in 0..<self.values.count {
            sum += self.values[index]*self.values[index]
        }
        
        return Double(sum)
    }
    
    mutating func recomputeMagnitude(){
        self.magnitudeSquared = self.computeMagnitude()
    }
    
    // MARK: VectorArithmetic
    var magnitudeSquared: Double // squared magnitude of the vector
    
    mutating func scale(by rhs: Double) {
        // scale vector with a scalar
        // = each value is multiplied by rhs
        for index in 0..<values.count {
            values[index] *= rhs
        }
        self.magnitudeSquared = self.computeMagnitude()
    }
    
    // MARK: AdditiveArithmetic
    
    // zero is identity element for aditions
    // = all values are zero
    static var zero: Vector = Vector()
    
    static func + (lhs: Vector, rhs: Vector) -> Vector {
        var retValues = [Double]()
        
        for index in 0..<min(lhs.values.count, rhs.values.count) {
            retValues.append(lhs.values[index] + rhs.values[index])
        }
        
        return Vector(with: retValues)
    }
    
    static func += (lhs: inout Vector, rhs: Vector) {
        for index in 0..<min(lhs.values.count,rhs.values.count)  {
            lhs.values[index] += rhs.values[index]
        }
        lhs.recomputeMagnitude()
    }

    static func - (lhs: Vector, rhs: Vector) -> Vector {
        var retValues = [Double]()
        
        for index in 0..<min(lhs.values.count, rhs.values.count) {
            retValues.append(lhs.values[index] - rhs.values[index])
        }
        
        return Vector(with: retValues)
    }
    
    static func -= (lhs: inout Vector, rhs: Vector) {
        for index in 0..<min(lhs.values.count,rhs.values.count)  {
            lhs.values[index] -= rhs.values[index]
        }
        lhs.recomputeMagnitude()
    }
}


