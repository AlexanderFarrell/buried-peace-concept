//
//  LegendGame.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/31/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

enum LegendError: Error
{
    case LegendAlreadyExists
    case LoadedLegendWhichDoesntExist
    case FailedDecodeJSONHeader
    case FailedEncodeJSONHeader
    case FailedEncodeJSONCaveSegment
    case FailedLoadHeaderFile
    case FailedSaveHeaderFile
    case FailedLoadChapterSheetFile
    case FailedSaveChapterSheetFile
    case NoSegment
    case NoSegmentColumn
    case FailedToLoadColumn
    case FailedToCreateColumn
    
    //Admin
    case FailedToCreateLegendDirectory(directory: String)
}

class LegendGame: NSObject {
    var header: LegendHeader = LegendHeader()
    var bufferedScene: WorldScene?
    var directoryURL: URL!
    var displayColorRed: Float = 1.0
    var displayColorGreen: Float = 0.0
    var displayColorBlue: Float = 0.0
    
    init(url: URL) throws {
        directoryURL = url
        
        if !(FileManager.default.fileExists(atPath: url.path))
        {
            throw LegendError.LoadedLegendWhichDoesntExist
        }
        
        super.init()
    }
    
    init(filename: String) throws {
        super.init()
        
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let legendsDirectory = documentsDirectory.appendingPathComponent("Legends")
        let legendURL = legendsDirectory.appendingPathComponent(filename)
        
        if FileManager.default.fileExists(atPath: legendsDirectory.appendingPathComponent(filename).path)
        {
            throw LegendError.LegendAlreadyExists
        }
        
        do {
            try FileManager.default.createDirectory(atPath: legendURL.path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            throw LegendError.FailedToCreateLegendDirectory(directory: "Main Directory for the Legend")
        }
        
        directoryURL = legendURL
        
        createSubdirectory(nameOfDirectory: "Header")
        createSubdirectory(nameOfDirectory: "Chapters")
        createSubdirectory(nameOfDirectory: "Assets")
        
    }
    
    private func createSubdirectory(nameOfDirectory: String)
    {
        let dataPath = directoryURL.appendingPathComponent(nameOfDirectory)
        
        do {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            print("Created Directory: " + nameOfDirectory)
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)" + nameOfDirectory)
        }
    }
    
    //MARK: - Create
    
    
    //MARK: - Header
    private func getURLHeader() -> URL
    {
        return directoryURL.appendingPathComponent("Header").appendingPathComponent("Header.json")
    }
    
    func loadHeader() throws
    {
        let urlHeader = getURLHeader()
        let decoder = getJSONDecoder()
        
        do {
            let data = try Data.init(contentsOf: urlHeader)
            
            do {
                header = try decoder.decode(LegendHeader.self, from: data)
            } catch {
                throw LegendError.FailedDecodeJSONHeader
            }
            
        } catch {
            throw LegendError.FailedLoadHeaderFile
        }
    }
    
    func saveHeader() throws
    {
        let urlHeader = getURLHeader()
        let encoder = getJSONEncoder()
        
        var data: Data = Data()
        var successful = false
        
        do {
            data = try encoder.encode(header)
            successful = true
            
        } catch {
            throw LegendError.FailedEncodeJSONHeader
        }
        
        if successful
        {
            //We will override the file if so.
            deleteHeader()
            
            do {
                try data.write(to: urlHeader)
            } catch {
                throw LegendError.FailedSaveHeaderFile
            }
        }
    }
    
    func deleteHeader()
    {
        let urlHeader = getURLHeader()
        
        if FileManager.default.fileExists(atPath: urlHeader.path)
        {
            do {
                try FileManager.default.removeItem(atPath: urlHeader.path)
            } catch {
                print("Could not remove the file.")
            }
        }
        else
        {
            print("No item to delete.")
        }
    }
    
    //Mark: - Scene
    
    func loadScene()
    {
        
    }
    
    func saveScene()
    {
        
    }
    
    //MARK: - Cave Segment
    private func getCaveSegmentURL(x: Int, y: Int, scene: String) -> URL
    {
        return directoryURL.appendingPathComponent("WorldScenes").appendingPathComponent(scene).appendingPathComponent(String(x)).appendingPathComponent(String(y) + ".segcavebp")
    }
    
    private func getCaveSegmentColumnURL(x: Int, scene: String) -> URL
    {
        return directoryURL.appendingPathComponent("WorldScenes").appendingPathComponent(scene).appendingPathComponent(String(x))
    }
    
    func loadCaveSegment(x: Int, y: Int, scene: String) throws -> CaveSegmentSer?
    {
        let urlSegment = getCaveSegmentURL(x: x, y: y, scene: scene)
        let decoder = getJSONDecoder()
        var retVal: CaveSegmentSer? = nil
        
        do {
            let data = try Data.init(contentsOf: urlSegment)
            
            do {
                retVal = try decoder.decode(CaveSegmentSer.self, from: data)
            } catch {
                
                //Instead of throwing an exception, we just return nil. This is because we may try to see if there are segments in places which havent been loaded.
                retVal = nil
            }
            
        } catch {
            throw LegendError.NoSegment
        }
        
        return retVal
    }
    
    func saveCaveSegment(segment: CaveSegmentSer, scene: String) throws
    {
        let urlSegment = getCaveSegmentURL(x: segment.xInSegments, y: segment.yInSegments, scene: scene)
        let encoder = getJSONEncoder()
        
        var data: Data = Data()
        var successful = false
        
        do {
            data = try encoder.encode(segment)
            successful = true
            
        } catch {
            throw LegendError.FailedEncodeJSONCaveSegment
        }
        
        if successful
        {
            //We will override the file if so.
            deleteHeader()
            
            //Then we will check if there is a column
            let urlColumn = getCaveSegmentColumnURL(x: segment.xInSegments, scene: scene)
            
            if !FileManager.default.fileExists(atPath: urlColumn.path)
            {
                do {
                    //TODO: Make URL Based
                    try FileManager.default.createDirectory(atPath: urlColumn.path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    throw LegendError.FailedToCreateColumn
                }
            }
            
            do {
                try data.write(to: urlSegment)
            } catch {
                throw LegendError.FailedSaveHeaderFile
            }
        }
    }
    
    //TODO: Add a method to ignore deleting the column, in the case of saving a column. This way it doesn't delete the directory and then reopen it.
    func deleteCaveSegment(x: Int, y: Int, scene: String) throws
    {
        let urlSegment = getCaveSegmentURL(x: x, y: y, scene: scene)
        
        if FileManager.default.fileExists(atPath: urlSegment.path)
        {
            do {
                try FileManager.default.removeItem(atPath: urlSegment.path)
                
                //If this happened, we want to see if this was the last segment in the column. If it is, we will delete the directory
                let urlColumn = getCaveSegmentColumnURL(x: x, scene: scene)
                
                var contentsOfColumn: [URL] = [URL]()
                
                do {
                    try contentsOfColumn = FileManager.default.contentsOfDirectory(at: urlColumn, includingPropertiesForKeys: nil, options: [])
                    
                } catch {
                    throw LegendError.FailedToLoadColumn
                }
                
                if (contentsOfColumn.count < 1)
                {
                    do {
                        try! FileManager.default.removeItem(at: urlColumn)
                    }
                }
                
            } catch {
                print("Could not remove the file.")
            }
        }
        else
        {
            print("No item to delete.")
        }
    }
    
    
    //MARK: - Assets
    //TODO: Create methods for asset management
    func loadAssets()
    {
        
    }
    
    func saveAsset()
    {
        
    }
    
    //MARK: - Admin
    func getJSONDecoder() -> JSONDecoder
    {
        let decoder = JSONDecoder.init()
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "positiveInfinity", negativeInfinity: "negativeInfinity", nan: "floatNan")
        
        return decoder
    }
    
    func getJSONEncoder() -> JSONEncoder
    {
        let encoder = JSONEncoder.init()
        encoder.nonConformingFloatEncodingStrategy = .convertToString(positiveInfinity: "positiveInfinity", negativeInfinity: "negativeInfinity", nan: "floatNan")
        
        return encoder
    }
}

/*
 struct LegendGame: Codable {
 //var chapters: [Chapter] = [Chapter]()
 var name: String// = "Legend"
 var descriptionLegend: String// = "This is where the description of the legend should go! \n \nFill in as much information as you want! Put a hook in to attract your players."
 var chapter: Chapter = Chapter()
 var displayColorRed: Float = 1.0
 var displayColorGreen: Float = 0.0
 var displayColorBlue: Float = 0.0
 }
 */
