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
                self.processAdding(of: newSeries)
                self.delegate?.eventSourceReaderDidReceiveNewDataPackage()
            }
        }
    }
    
    private func eventSourceError(event: Event?) {
        self.delegate?.eventSourceReaderDidReceiveError()
    }
    
    // MARK: - Private instance
    private func processAdding(of series: [NDREventSerie]) {
        for eventSerie in series {
            if let existedSerieIndex = self.latestData.index(where: { $0.name == eventSerie.name }) {
                if (eventSerie.measurements.count > 0) {
                    self.latestData[existedSerieIndex] = eventSerie
                }
            } else {
                self.latestData.append(eventSerie)
            }
        }
    }
}
