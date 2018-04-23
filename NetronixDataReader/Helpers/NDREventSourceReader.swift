//
//  NDREventSourceReader.swift
//  NetronixDataReader
//
//  Created by Anton Holub on 4/22/18.
//  Copyright © 2018 Anton Holub. All rights reserved.
//

import Foundation
import EventSource

protocol NDREventSourceReadarListener: class {
    func eventSourceReaderDidEstablishConnection()
    func eventSourceReaderDidReceiveNewDataPackage()
    func eventSourceReaderDidReceiveError()
}

final class NDREventSourceReader {
    static let sharedInstacne = NDREventSourceReader()
    
    private var eventSource: EventSource?
    
    weak var delegate: NDREventSourceReadarListener?
    var latestData: [NDREventSerie] = [NDREventSerie]()
    
    
    func startListening(from url: URL?) {
        if (self.eventSource == nil) {
            self.eventSource = EventSource(url: url)
            self.eventSource?.onOpen(eventSourceConnectionEstablished)
            self.eventSource?.onMessage(eventSourceEventRecieved)
            self.eventSource?.onError(eventSourceError)
        }
    }
    
    // MARK: - EventSource callbacks
    private func eventSourceConnectionEstablished(event: Event?) {
        self.delegate?.eventSourceReaderDidEstablishConnection()
    }
    
    private func eventSourceEventRecieved(event: Event?) {
        if let jsonData = event?.data.data(using: .utf8) {
            if let newSeries = try? JSONDecoder().decode([NDREventSerie].self, from: jsonData) {
                if (self.add(series: newSeries)) {
                    self.delegate?.eventSourceReaderDidReceiveNewDataPackage()
                }
            }
        }
    }
    
    private func eventSourceError(event: Event?) {
        self.delegate?.eventSourceReaderDidReceiveError()
    }
    
    // MARK: - Private instance
    private func add(series: [NDREventSerie]) -> Bool {
        var seriesDataUpdated = false
        for eventSerie in series {
            if let existedSerieIndex = self.latestData.index(where: { $0.name == eventSerie.name }) {
                // Updating serie if same serie name was alread existed
                if (eventSerie.measurements.count > 0) {
                    // Making measurement with latest timestamp be on first place
                    eventSerie.measurements.sort { $0.timestamp > $1.timestamp }
                    
                    // Updating serie with existed name only if new timestamp is newer than existed
                    let existedSerieTimestamp = self.latestData[existedSerieIndex].measurements.first?.timestamp ?? 0
                    let newSerieTimestamp = eventSerie.measurements.first?.timestamp ?? 0
                    if (existedSerieTimestamp < newSerieTimestamp) {
                        self.latestData[existedSerieIndex] = eventSerie
                        seriesDataUpdated = true
                    }
                }
            } else {
                // Adding serie with non-existed name
                self.latestData.append(eventSerie)
                seriesDataUpdated = true
            }
        }
        
        return seriesDataUpdated
    }
}
