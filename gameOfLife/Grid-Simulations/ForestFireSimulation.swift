//
//  ForestFireSimulation.swift
//  Grid-Simulations
//
//  Created by vanya rohatgi on 6/22/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation

public class ForestFireSimulation: Simulation {
    var newGrid: [[Character?]] = []

public override func setup() {
    grid = [[Character?]](repeating: [Character?](repeating: nil, count: 10), count: 10)
    for x in 0..<8 {
        for y in 0..<10 {
            if randomZeroToOne() < 0.05 {
                grid[x][y] = "🌳"
                }
            else if randomZeroToOne() < 0.05 {
                grid[x][y] = "🌱"
                }
            else {
                grid[x][y] = nil
                }
        }
    }
}
    
public override func update() {
    jerkTrees()
}
    
func isLegalPosition(x: Int, y: Int) -> Bool {
    if x >= 0 && x < grid.count && y >= 0 && y < grid[0].count {
        return true
    }
    else {
        return false
    }
}
    
func getNeighborPositions(x originX: Int, y originY: Int) -> [(x: Int, y: Int)] {
    var neighbors: [(x: Int, y: Int)] = []
    for x in originX - 1...originX + 1 {
    for y in originY - 1...originY + 1 {
        if isLegalPosition(x: x, y: y) {
        if !(x == originX && y == originY) {
            neighbors.append((x, y)) }
        }
        }
    }
    return neighbors
    }

func thunderboltAndLightning() {
    newGrid = grid
    for y in 0..<grid[0].count {
    for x in 0..<grid.count {
        let tile = grid[x][y]
        if tile == nil {
        if randomZeroToOne() < 0.003 {
            newGrid[x][y] = "🌲"
            }
        } else if tile == "🌲" {
            let neighborCords = getNeighborPositions(x: x, y: y)
            for neighborCoord in neighborCords {
                let neighbor = grid[neighborCoord.x][neighborCoord.y]
                    if neighbor == "🔥" {
                        newGrid[x][y] = "🔥"
                    }
                    else if randomZeroToOne() < 0.0001 {
                        newGrid[x][y] = "🔥"
                    }
            }
        } else if tile == "🔥" {
                newGrid[x][y] = nil
        }
        }
    }
        grid = newGrid
    }

func aTinyForest() {
    newGrid = grid
    for y in 0..<grid[0].count {
    for x in 0..<grid.count {
        let tile = grid[x][y]
        if tile == nil {
            if randomZeroToOne() < 0.001 {
                newGrid[x][y] = "🌲"
                }
            } else if tile == "🌲" {
                let neighborCords = getNeighborPositions(x: x, y: y)
                for neighborCoord in neighborCords {
                    let neighbor = grid[neighborCoord.x][neighborCoord.y]
                    if neighbor == "🔥" {
                        newGrid[x][y] = "🔥"
                    }
                }
            } else if tile == "🔥" {
                newGrid[x][y] = nil
            }
        }
    }
    grid = newGrid
}
    
func noMercy() {
    newGrid = grid
    for y in 0..<grid[0].count {
    for x in 0..<grid.count {
        let tile = grid[x][y]
        if tile == nil {
            if randomZeroToOne() < 0.01 {
                    newGrid[x][y] = "🌲"
                    }
            } else if tile == "🌲" {
                let neighborCords = getNeighborPositions(x: x, y: y)
                for neighborCoord in neighborCords {
                    let neighbor = grid[neighborCoord.x][neighborCoord.y]
                    if neighbor == "🔥" {
                        newGrid[x][y] = "🔥"
                        }
                        else if neighbor == "✄" {
                            newGrid[x][y] = nil
                        }
                        else if randomZeroToOne() < 0.0001 {
                            newGrid[x][y] = "🔥"
                        }
                    }
                }
                else if tile == "🔥" {
                    newGrid[x][y] = nil
                }
        }
    }
        grid = newGrid
}
    
func jerkTrees() {
    newGrid = grid
    for y in 0..<grid[0].count {
    for x in 0..<grid.count {
        let tile = grid[x][y]
            if tile == nil {
                if randomZeroToOne() < 0.005 {
                    newGrid[x][y] = "🌳" }
                else if randomZeroToOne() < 0.01 {
                    newGrid[x][y] = "🌱" }}
            else if tile == "🌳" {
                var numberOfJerks: Int = 0
                let neighborCords = getNeighborPositions(x: x, y: y)
                for neighborCoord in neighborCords {
                let neighbor = grid[neighborCoord.x][neighborCoord.y]
                if neighbor == "✄"{
                    newGrid[x][y] = nil }
                else if neighbor == "🌱" {
                    numberOfJerks += 1
                if numberOfJerks >= 4 {
                    newGrid[x][y] = nil
                }
                }
                }
            }
            else if tile == "🌱" {
                let neighborCords = getNeighborPositions(x: x, y: y)
                for neighborCoord in neighborCords {
                let neighbor = grid[neighborCoord.x][neighborCoord.y]
                if neighbor == "🔥" {
                    newGrid[x][y] = "🔥"
                }
                else if randomZeroToOne() < 0.0001 {
                    newGrid[x][y] = "🔥"
                    }
                }
            }
            else if tile == "🔥" {
                newGrid[x][y] = nil
            }
        }
    }
    grid = newGrid
    }
}



