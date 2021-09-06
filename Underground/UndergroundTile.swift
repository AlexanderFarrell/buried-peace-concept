//
//  UndergroundTile.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/27/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

protocol TileDelegate {
    func getParentTile() -> UndergroundTile
}

enum TileSectionTypes
{
    case Natural
    case Mine
    case Base
    case Ruins
}

enum UTileTypes
{
    case HumanEncampment
    case Unsettled
    case Instance
}

class UndergroundTile: GameplayObject, TileDelegate {
    func getParentTile() -> UndergroundTile {
        return self
    }
    
    //DNA
    var x = 0
    var y = 0
    var layer = 0
    
    var encampment: Encampment?
    var unsettledArea: UnsettledArea?
    var instanceDungeon: InstanceDungeon?
    var numberOfRooms: Int = 1
    var pathToLowerLayer: Bool = false
    var pathToUpperLayer: Bool = false
    
    var connectingTileWest: UndergroundTile?
    var connectingTileEast: UndergroundTile?
    var connectingTileNorth: UndergroundTile?
    var connectingTileSouth: UndergroundTile?
    var connectingTileAbove: UndergroundTile?
    var connectingTileBelow: UndergroundTile?
    
    var discoveredByPlayer: Bool = false
    
    var hasWestConnection: Bool
    {
        get
        {
            return (connectingTileWest != nil)
        }
    }
    var hasEastConnection: Bool
    {
        get
        {
            return (connectingTileEast != nil)
        }
    }
    var hasNorthConnection: Bool
    {
        get
        {
            return (connectingTileNorth != nil)
        }
    }
    var hasSouthConnection: Bool
    {
        get
        {
            return (connectingTileSouth != nil)
        }
    }
    var hasAboveConnection: Bool
    {
        get
        {
            return (connectingTileAbove != nil)
        }
    }
    var hasBelowConnection: Bool
    {
        get
        {
            return (connectingTileBelow != nil)
        }
    }
    
    var tileSections = [TileSectionTypes]()
    
    var generationRandom: ClayRandom!
    
    //Generated
    var tileType: UTileTypes = UTileTypes.Unsettled
    
    override func generate() {
        generationRandom = getRandom()
        let random = ClayRandom.init(seed: getSeed(), quality: ClayRandomQuality.HighQualityCRandom)
        
        let lowestLayerProbabilityCity = 0.02
        let highestLayerProbabilityCity = 0.17
        let layerNormalizedProbabilityCity = 1.0 - (Double(layer)/100.0)
        
        if (layer > 0) && (layer < getUnderground().maxLayers)
        {
            if getUnderground().hasTile(x: x, y: y, layer: layer - 1)
            {
                if getUnderground().getTile(x: x, y: y, layer: layer - 1)!.pathToLowerLayer
                {
                    pathToUpperLayer = true //Just do the opposite for ways up? Or randomly place ways up? (Ways down being abyssal and would kill you to fall into?)
                }
            }
        }
        
        let probabilityOfCity = lowestLayerProbabilityCity + ((highestLayerProbabilityCity - lowestLayerProbabilityCity) * layerNormalizedProbabilityCity)
        
        if random.nextFloatUnit() < Float(probabilityOfCity)
        {
            tileType = .HumanEncampment
        }
        else
        {
            let lowestLayerProbabilityInstance = 0.09
            let highestLayerProbabilityInstance = 0.15
            let layerNormalizedProbabilityInstance = (Double(layer)/100.0)
            
            let probabilityOfInstance = lowestLayerProbabilityInstance + ((highestLayerProbabilityInstance - lowestLayerProbabilityInstance) * layerNormalizedProbabilityInstance)
            
            if random.nextFloatUnit() < Float(probabilityOfInstance)
            {
                tileType = .Instance
            }
            else
            {
                tileType = .Unsettled
            }
        }
        
        switch tileType {
        case .HumanEncampment:
            encampment = Encampment()
            encampment!.random = random
            encampment!.tileDelegate = self
            encampment!.gameplayDelegate = gameplayDelegate
            encampment!.name = getMacroWorld().EncampmentNames[random.nextIntMaxValue(maxValue: getMacroWorld().EncampmentNames.count)]
            numberOfRooms = random.nextIntInRange(minValue: 20, maxValue: 50)
            encampment!.generate()
            break
        case .Instance:
            instanceDungeon = InstanceDungeon()
            instanceDungeon!.random = random
            instanceDungeon!.tileDelegate = self
            instanceDungeon!.bossName = getMacroWorld().BossNames[random.nextIntMaxValue(maxValue: getMacroWorld().BossNames.count)]
            instanceDungeon!.name = getMacroWorld().InstanceNames[random.nextIntMaxValue(maxValue: getMacroWorld().InstanceNames.count)]
            instanceDungeon!.gameplayDelegate = gameplayDelegate
            numberOfRooms = random.nextIntInRange(minValue: 130, maxValue: 300)
            instanceDungeon!.generate()
            break
        case .Unsettled:
            unsettledArea = UnsettledArea()
            numberOfRooms = random.nextIntInRange(minValue: 30, maxValue: 100)
            unsettledArea!.random = random
            unsettledArea!.tileDelegate = self
            unsettledArea!.gameplayDelegate = gameplayDelegate
            unsettledArea!.generate()
            break
        }
        
        if tileSections.count < 1
        {
            tileSections.append(.Natural)
        }
    }
    
    func getSeed() -> UInt64
    {
        return UInt64(UInt64(x) + (UInt64(y) * UInt64(ClayRandom.maxValueForBits(bitCount: 28))) + (UInt64(layer) * UInt64(ClayRandom.maxValueForBits(bitCount: 56))))
    }
    
    func getRandom() -> ClayRandom
    {
        return ClayRandom.init(seed: getSeed(), quality: ClayRandomQuality.HighQualityCRandom)
    }
}
