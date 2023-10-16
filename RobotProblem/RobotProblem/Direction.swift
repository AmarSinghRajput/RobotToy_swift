//
//  Direction.swift
//  RobotProblem
//
//  Created by Amar Singh on 15/10/23.
//

import Foundation
/*
             NORTH
              ^
 WEST<--------|--------->EAST
              |
              v
            SOUTH
 */
enum Direction: String {
    case east
    case west
    case north
    case south
    case none
    
    init?(rawValue: String) {
        switch rawValue {
        case "east":
            self = .east
        case "west":
            self = .west
        case "north":
            self = .north
        case "south":
            self = .south
        default:
            self = .none
        }
    }
    
    func turnLeft() -> Direction {
        switch self {
        case .north:
            return .west
        case .south:
            return .east
        case .east:
            return .north
        case .west:
            return .south
        default:
            return self
        }
    }
    
    func turnRight() -> Direction {
        switch self {
        case .north:
            return .east
        case .south:
            return .west
        case .east:
            return .south
        case .west:
            return .north
        default:
            return self
        }
    }
}
