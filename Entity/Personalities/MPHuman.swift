//
//  MPHuman.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

enum GenderMPHuman {
    case Male
    case Female
}

enum HealthMPHuman {
    case Conscious
    case Unconscious
}

class MPHuman: MacroPersonality {
    var gender: GenderMPHuman = GenderMPHuman.Female
    var role: String = "Chef"
    var health: HealthMPHuman!
    
    var genderPronounToString: String {
        get {
            if gender == .Male
            {
                return "He"
            }
            else
            {
                return "She"
            }
        }
    }
    
    var genderPosessiveToString: String {
        get {
            if gender == .Male
            {
                return "His"
            }
            else
            {
                return "Her"
            }
        }
    }
    
    override func setup() {
        
    }
    
    func createPersonality(random: ClayRandom)
    {
        self.gender = MPHuman.randomlyDetermineGender(random: random)
        
        if self.gender == .Male
        {
            self.name = getMacroWorld().HumanMaleNames[random.nextIntMaxValue(maxValue: getMacroWorld().HumanMaleNames.count)]
        }
        else
        {
            self.name = getMacroWorld().HumanFemaleNames[random.nextIntMaxValue(maxValue: getMacroWorld().HumanFemaleNames.count)]
        }
        
        //Profession
        role = getMacroWorld().HumanProfessions[random.nextIntMaxValue(maxValue: getMacroWorld().HumanProfessions.count)].capitalized
        
        //Add to story
        createStory(random: random)
    }
    
    func createStory(random: ClayRandom)
    {
        //Origin
        switch random.nextIntMaxValue(maxValue: 4) {
        case 0:
            story.append("I came from a " + getMacroWorld().EncampmentNames[random.nextIntMaxValue(maxValue: getMacroWorld().EncampmentNames.count)].lowercased() + " called " + getMacroWorld().HumanFemaleNames[random.nextIntMaxValue(maxValue: getMacroWorld().HumanFemaleNames.count)] + " far away from here.")
            break
        case 1:
            story.append("I've wandered my whole life until I found this encampment"/* + getCurrentTile()!.encampment!.name.lowercased()*/ + ", and settled here.")
            break
        case 2:
            story.append("I can't remember much of my childhood...")
            break
        default:
            break
        }
        
        //How I got here
        switch random.nextIntMaxValue(maxValue: 3) {
        case 0:
            story.append("I fought many monsters on my journey here.")
        case 1:
            story.append("I was too young to remember traveling here" /* + getCurrentTile()!.encampment!.name.lowercased()*/ + ".")
        default:
            break
        }
        
        //How I became what I am
        
        //Who I am
    }
    
    override func generateMesh() -> REMesh {
        return ClayBox.makeBox(xCenter: 0.0, yCenter: 0.9, zCenter: 0.0, xLength: 0.75, yLength: 1.8, zLength: 0.75).getClayMesh(detail: 2).getMeshVertexPosTex(renderer: getRenderer())
    }
    
    override func generateTexture() -> RETexture {
        return RETexture.init(clayImage: ClayImage.init(red: getRandomMicro().nextFloatUnit(), green: getRandomMicro().nextFloatUnit(), blue: getRandomMicro().nextFloatUnit(), alpha: 1.0), renderer: getRenderer(), mipmapped: false)
    }
    
    class func randomlyDetermineGender(random: ClayRandom) -> GenderMPHuman
    {
        var retValGender: GenderMPHuman
        
        if random.nextBool()
        {
            retValGender = .Male
        }
        else
        {
            retValGender = .Female
        }
        
        return retValGender
    }
}
