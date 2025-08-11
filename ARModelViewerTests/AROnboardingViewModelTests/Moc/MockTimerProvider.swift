//
//  MockTimerProvider.swift
//  ARModelViewerTests
//
//  Created by Dmitriy Eliseev on 10.08.2025.
//

import Foundation
import Combine
@testable import ARModelViewer

final class MockTimerProvider: ITimerProvider { }

extension MockTimerProvider {
    /// Starts a timer that emits events at short intervals to simulate rapid timer ticks
    /// This is intended for testing purposes to ensure fast and predictable timer behavior
    func start(every interval: TimeInterval) -> AnyPublisher<Date, Never> {
        return Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .prefix(4)
            .eraseToAnyPublisher()
    }
}
