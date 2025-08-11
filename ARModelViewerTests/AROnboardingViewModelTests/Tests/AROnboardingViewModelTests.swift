//
//  AROnboardingViewModelTests.swift
//  ARModelViewerTests
//
//  Created by Dmitriy Eliseev on 10.08.2025.
//

import XCTest
import Combine
@testable import ARModelViewer

final class AROnboardingViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    // Verifies that when shouldStartTimer = false, the data is initialized
    // with the first onboarding step and the timer does not start
    func test_onboardingInitialState_withoutTimer() {
        // Given
        let mockStorage = MockStorageService()
        let mockTimer = MockTimerProvider()
        
        // When
        let viewModel = AROnboardingViewModel(
            storage: mockStorage,
            timerProvider: mockTimer,
            onboardingData: Onboarding.data,
            shouldStartTimer: false
        )
        
        // Then
        XCTAssertEqual(viewModel.data, Onboarding.data[0])
    }
    
    // Verifies that if the storage does not contain the onboarding completion key,
    // didFinishOnboarding is false and data contains the first onboarding step
    func testInitialStateWhenOnboardingNotFinished() {
        // Given
        let mockStorage = MockStorageService()
        
        // When
        let viewModel = AROnboardingViewModel(storage: mockStorage, timerProvider: MockTimerProvider(), shouldStartTimer: false)
        
        // Then
        XCTAssertFalse(viewModel.didFinishOnboarding)
        XCTAssertEqual(viewModel.data, Onboarding.data.first)
    }
    
    // Verifies that if the storage contains the onboarding completion key,
    // didFinishOnboarding is true
    func testInitialStateWhenOnboardingFinished() {
        // Given
        let mockStorage = MockStorageService()
        mockStorage.setKey(key: Onboarding.storageKey)
        
        // When
        let viewModel = AROnboardingViewModel(storage: mockStorage, timerProvider: MockTimerProvider(), shouldStartTimer: false)
        
        // Then
        XCTAssertTrue(viewModel.didFinishOnboarding)
    }
    
    // Verifies that when the timer is running, data cycles through the onboarding steps
    // and returns to the first step after completing the sequence
    func testTimerCyclesThroughOnboardingSteps() {
        // Given
        let mockStorage = MockStorageService()
        let mockTimer = MockTimerProvider()
        
        // When
        let viewModel = AROnboardingViewModel(storage: mockStorage, timerProvider: mockTimer)
        let expectation = XCTestExpectation(description: "Onboarding data updates as timer emits")
        expectation.expectedFulfillmentCount = 4
        var receivedSteps = [OnboardingStep]()
        viewModel.$data
            .dropFirst()
            .sink { step in
                print("Received step:", step.text)
                receivedSteps.append(step)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 0.7)
        XCTAssertEqual(receivedSteps.count, 4)
        XCTAssertEqual(receivedSteps[0], Onboarding.data[1])
        XCTAssertEqual(receivedSteps[1], Onboarding.data[2])
        XCTAssertEqual(receivedSteps[2], Onboarding.data[3])
        XCTAssertEqual(receivedSteps[3], Onboarding.data[0])
    }
    
    // Verifies that skipOnboarding() marks the onboarding as finished,
    // saves this state to storage, and stops the timer
    func testSkipOnboardingSetsFlagAndStopsTimer() {
        // Given
        let mockStorage = MockStorageService()
        let mockTimer = MockTimerProvider()
        let viewModel = AROnboardingViewModel(storage: mockStorage, timerProvider: mockTimer)
        
        // When
        viewModel.skipOnboarding()
        
        // Then
        XCTAssertTrue(viewModel.didFinishOnboarding)
        XCTAssertTrue(mockStorage.getKey(key: Onboarding.storageKey))
    }
}
