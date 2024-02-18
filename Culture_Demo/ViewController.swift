//
//  ViewController.swift
//  Culture_Demo
//
//  Created by tw on 2/18/24.
//

import UIKit
import EventKit

final class ViewController: UIViewController {

    private let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        eventStore.requestFullAccessToEvents { [weak self] state, error in
            guard let self else { return }
            switch state {
            case true:
                if let calendar = self.eventStore.defaultCalendarForNewEvents {
                    let newEvent = EKEvent(eventStore: self.eventStore)
                    newEvent.calendar = calendar
                    newEvent.title = "새 이벤트"
                    newEvent.startDate = Date()
                    // 1시간 후
                    newEvent.endDate = Date().addingTimeInterval(60 * 60)
                    
                    do {
                        try eventStore.save(newEvent, span: .thisEvent)
                    } catch {
                        
                    }
                }
            case false: break
            }
        }
    }
}


