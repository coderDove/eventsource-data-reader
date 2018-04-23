//
//  NDREventSerie.swift
//  NetronixDataReader
//
//  Created by Anton Holub on 4/22/18.
//  Copyright © 2018 Anton Holub. All rights reserved.
//

final class NDREventSerie: Decodable {
    var id: String
    var name: String
    var unit: String
    var measurements: [NDRMeasurement]
    
    enum NDREventSerieCodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case unit
        case measurements
    }
    
    init(from decoder: Decoder) throws {
        let decodeContainer = try decoder.container(keyedBy: NDREventSerieCodingKeys.self)
        self.id = try decodeContainer.decode(String.self, forKey: .id)
        self.name = try decodeContainer.decode(String.self, forKey: .name)
        
        // Making separate parsing of measurments and unit values for Location and for all other series
        if (name == "Location") {
            self.unit = "Lat/Long"
            self.measurements =  try decodeContainer.decode([NDRLocationMeasurement].self, forKey: .measurements)
        } else {
            self.unit = try decodeContainer.decode(String.self, forKey: .unit)
            self.measurements =  try decodeContainer.decode([NDRValueMeausrement].self, forKey: .measurements)
        }
    }
}
