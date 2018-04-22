//
//  Measurement.swift
//  NetronixDataReader
//
//  Created by Anton Holub on 4/22/18.
//  Copyright © 2018 Anton Holub. All rights reserved.
//

protocol NDRMeasurement: Decodable {
    var timestamp: Int { get set }
}

final class NDRValueMeausrement: NDRMeasurement {
    var timestamp: Int
    var value: Float
    
     init (from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.timestamp = try container.decode(Int.self)
        self.value = try container.decode(Float.self)
    }
}

final class NDRLocationMeasurement: NDRMeasurement {
    var timestamp: Int
    var location: [Float]
    
    required init (from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.timestamp = try container.decode(Int.self)
        self.location = try container.decode([Float].self)
    }
}

