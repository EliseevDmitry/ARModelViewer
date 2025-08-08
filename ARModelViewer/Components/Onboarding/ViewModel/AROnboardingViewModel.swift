//
//  AROnboardingViewModel.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 07.08.2025.
//

import Foundation
import Combine

final class AROnboardingViewModel: ObservableObject {
    @Published var data: OnboardingStep
    @Published var didFinishOnboarding: Bool
    private let storageService: IStorageService
    private let timerProvider: ITimerProvider
    private let onboardingData: [OnboardingStep]
    private var currentIndex = 0
    private var timer: AnyCancellable?
    
    // MARK: - Initialization
    init(
        storage: IStorageService = Storage(),
        timerProvider: ITimerProvider = TimerProvider(),
        onboardingData: [OnboardingStep] = Onboarding.data,
        shouldStartTimer: Bool = true
    ) {
        self.storageService = storage
        self.timerProvider = timerProvider
        self.onboardingData = onboardingData
        self.data = onboardingData[currentIndex]
        let onboarding = storage.getKey(key: Onboarding.storageKey)
        self.didFinishOnboarding = onboarding
        if !didFinishOnboarding && shouldStartTimer {
            setTimer()
        }
    }
    
    deinit {
        deleteTimer()
    }
}

// MARK: - Public Functions
extension AROnboardingViewModel {
    func skipOnboarding() {
        deleteTimer()
        setOnboarding()
        didFinishOnboarding = true
    }
}

// MARK: - Private Functions
extension AROnboardingViewModel {
    private func setTimer() {
        timer = timerProvider.start(every: 4)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.currentIndex = (self.currentIndex + 1) % self.onboardingData.count
                self.data = self.onboardingData[self.currentIndex]
            }
    }
    
    private func setOnboarding() {
        storageService.setKey(key: Onboarding.storageKey)
    }
    
    private func deleteTimer() {
        timer?.cancel()
    }
}
