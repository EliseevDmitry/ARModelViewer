//
//  ARViewContainer.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 31.07.2025.
//

import SwiftUI
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    let modelEntity: ModelEntity

    func makeCoordinator() -> Coordinator {
        Coordinator(model: modelEntity)
    }

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let focusEntity = FocusEntity(arView: arView)

        arView.configureForAR()
        arView.addGestures(using: context.coordinator)
        context.coordinator.updateCoordinator(arView: arView, focusEntity: focusEntity)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}













//проверить декомпозицию модуля

/*
import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    let modelEntity: ModelEntity
    
    //MARK: - Make ARView
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let focusEntity = FocusEntity(arView: arView)
        addGestures(
            arView: arView,
            coordinator: context.coordinator
        )
        arView.session.run(configurationARView())
        context.coordinator.updateCoordinator(
            arView: arView,
            focusEntity: focusEntity
        )
        return arView
    }
    
    //MARK: - Configuration ARView
    private func configurationARView() -> ARWorldTrackingConfiguration {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        return configuration
    }
    
    //MARK: - GestureRecognizers
    private func createTapGesture(coordinator: Coordinator) -> UITapGestureRecognizer {
        UITapGestureRecognizer(
            target: coordinator,
            action: #selector(Coordinator.handleTap)
        )
    }
    
    private func createPinchGesture(coordinator: Coordinator) -> UIPinchGestureRecognizer {
        UIPinchGestureRecognizer(
            target: coordinator,
            action: #selector(Coordinator.handlePinch)
        )
    }
    
    private func createRotationGesture(coordinator: Coordinator) -> UIRotationGestureRecognizer {
        UIRotationGestureRecognizer(
            target: coordinator,
            action: #selector(Coordinator.handleRotation)
        )
    }
    
    private func createPanGesture(coordinator: Coordinator) -> UIPanGestureRecognizer {
        UIPanGestureRecognizer(
            target: coordinator,
            action: #selector(Coordinator.handlePan)
        )
    }
    
    private func addGestures(arView: ARView, coordinator: Coordinator) {
        [createTapGesture(coordinator: coordinator),
         createPinchGesture(coordinator: coordinator),
         createRotationGesture(coordinator: coordinator),
         createPanGesture(coordinator: coordinator)
        ].forEach {
            arView.addGestureRecognizer($0)
        }
    }
    
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(model: modelEntity)
    }
    
    final class Coordinator: NSObject {
        private weak var arView: ARView?
        private var focusEntity: FocusEntity?
        private var focusTimer: Timer?
        private var isPlaced = false
        private var modelEntity: ModelEntity
        private var initialBoundingBox: SIMD3<Float>?
        private var initialScale: SIMD3<Float>?
        
        init(model: ModelEntity) {
            self.modelEntity = model
            self.initialBoundingBox = modelEntity.visualBounds(relativeTo: nil).extents
            self.initialScale = modelEntity.scale(relativeTo: nil)
        }
        
        deinit {
            focusTimer?.invalidate()
        }
        
        //MARK: - Functions
        func updateCoordinator(arView: ARView, focusEntity: FocusEntity) {
            self.arView = arView
            self.focusEntity = focusEntity
            focusTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak focusEntity] _ in
                DispatchQueue.main.async {
                    focusEntity?.updateStartPoint()
                }
            }
        }
        
        //MARK: - PRIVATE Functions
        private func setupParameters() {
            focusEntity?.isEnabled = false
            focusTimer?.invalidate()
            focusTimer = nil
            isPlaced = true
        }
        
        
        //MARK: - @OBJC Functions
        
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            guard !isPlaced,
                  let arView = arView,
                  let focusEntity = focusEntity
            else { return }
            
            // Получаем позицию focusEntity в мировых координатах
            let position = focusEntity.transform.translation
            
            // Получаем направление камеры
            let cameraTransform = arView.cameraTransform
            let forwardColumn = cameraTransform.matrix.columns.2
            let forward = simd_float3(forwardColumn.x, forwardColumn.y, forwardColumn.z)
            
            // Вычисляем угол поворота по оси Y (yaw)
            let yaw = atan2(forward.x, forward.z)
            let rotation = simd_quatf(angle: yaw, axis: [0, 1, 0])
            
            // Создаём якорь в позиции фокуса
            let anchor = AnchorEntity(world: position)
            
            // Задаём положение и ориентацию модели относительно якоря
            modelEntity.setPosition([0, 0, 0], relativeTo: nil)
            modelEntity.setOrientation(rotation, relativeTo: nil)
            
            // Добавляем модель к якорю и якорь в сцену
            anchor.addChild(modelEntity)
            arView.scene.addAnchor(anchor)
            
            setupParameters()
            isPlaced = true
        }
        
        
        @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
            guard gesture.state == .changed else { return }
            guard let _ = initialBoundingBox,
                  let initialScale = initialScale else { return }
            
            let scaleDelta = Float(gesture.scale)
            gesture.scale = 1
            
            var currentScale = modelEntity.scale(relativeTo: nil)
            currentScale *= scaleDelta
            
            let minLimit = initialScale * 0.25
            let maxLimit = initialScale * 3.5
            
            let clampedScale = SIMD3<Float>(
                x: min(max(currentScale.x, minLimit.x), maxLimit.x),
                y: min(max(currentScale.y, minLimit.y), maxLimit.y),
                z: min(max(currentScale.z, minLimit.z), maxLimit.z)
            )
            modelEntity.setScale(clampedScale, relativeTo: nil)
        }
        
        @objc func handleRotation(_ gesture: UIRotationGestureRecognizer) {
            guard gesture.state == .changed else { return }
            let angle = -Float(gesture.rotation)
            let rotation = simd_quatf(
                angle: angle,
                axis: [0, 1, 0]
            )
            modelEntity.orientation *= rotation
            gesture.rotation = 0
        }
        
        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let arView = arView else { return }
            //Получаем смещение пальца по экрану
            let translation = gesture.translation(in: arView)
            gesture.setTranslation(.zero, in: arView)
            //Чувствительность перемещения
            let panSensitivity: Float = 0.001
            //Получаем текущую матрицу трансформации камеры (положение и ориентация в мире)
            let cameraTransform = arView.cameraTransform
            //cameraForward — вектор, куда "смотрит" камера (ось Z)
            let cameraForward = cameraTransform.matrix.columns.2
            //cameraForward — вектор, куда "смотрит" камера (ось X)
            let cameraRight = cameraTransform.matrix.columns.0
            //движение по горизонтальной плоскости - XZ (Y=0)
            let deltaX = Float(translation.x) * panSensitivity
            let deltaZ = Float(translation.y) * panSensitivity
            
            // Преобразование вектора движения в мировые координаты
            let moveDirection =
            (deltaX * SIMD3<Float>(cameraRight.x, 0, cameraRight.z)) +
            (deltaZ * SIMD3<Float>(cameraForward.x, 0, cameraForward.z))
            
            var position = modelEntity.position(relativeTo: nil)
            position += moveDirection
            modelEntity.setPosition(position, relativeTo: nil)
        }
        
    }
}

*/
