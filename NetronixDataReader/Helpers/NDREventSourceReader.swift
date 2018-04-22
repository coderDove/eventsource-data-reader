//
//  NDREventSourceReader.swift
//  NetronixDataReader
//
//  Created by Anton Holub on 4/22/18.
//  Copyright © 2018 Anton Holub. All rights reserved.
//

import EventSource

final class NDREventSourceReader: NSObject {
    static let sharedInstacne = NDREventSourceReader()
    
    var eventSource: EventSource?
    
    func startListening(from url: URL) {
        if (self.eventSource == nil) {
            self.eventSource = EventSource(url: url)
            self.eventSource?.onOpen(eventSourceConnectionEstablished)
            self.eventSource?.onMessage(eventSourceEventRecieved)
            self.eventSource?.onError(eventSourceError)
        }
    }
    
    // MARK: - EventSource callbacks
    private func eventSourceConnectionEstablished(event: Event?) {
        
    }
    
    private func eventSourceEventRecieved(event: Event?) {
        
    }
    
    private func eventSourceError(event: Event?) {
        
    }
}
