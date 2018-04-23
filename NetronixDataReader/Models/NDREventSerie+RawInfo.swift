//
//  NDREventSerie+RawInfo.swift
//  NetronixDataReader
//
//  Created by Anton Holub on 4/23/18.
//  Copyright © 2018 Anton Holub. All rights reserved.
//

extension NDREventSerie {
    func actualMeasurementStringRepresentation() -> String {
        return "\(self.measurements.first?.toString() ?? "N/A") \(self.unit)";
    }
    
    func rawInfo() -> String {
        return "\(self.name) (\(self.unit)): \(self.measurements.first?.toString() ?? "N/A")"
    }
}
