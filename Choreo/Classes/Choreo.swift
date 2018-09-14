public class Choreo {
    public typealias AnimationCallback = (TimeInterval) -> ()
    public typealias ViewAnimationCallback = (UIView, TimeInterval) -> ()
    
    public init() {
    }
    
    public func prepareAnimations(_ prepareCallback: @escaping () -> ()) -> Self {
        self.prepareCallback = prepareCallback
        return self
    }
    
    public func addAnimationPhase(startFraction: Double, durationFraction: Double, animations: @escaping AnimationCallback) -> Self {
        let newPhase = AnimationPhase(start: startFraction, duration: durationFraction, animations: animations)
        phases.append(newPhase)
        return self
    }
    
    public func addStaggeredAnimation(views: [UIView], startFraction: Double, durationFraction: Double, delayFraction: Double, animation: @escaping ViewAnimationCallback) -> Self {
        let newPhase = AnimationPhase(start: startFraction, duration: durationFraction) { totalDuration in
            let viewCount = views.count
            let delay = delayFraction * totalDuration
            let totalDelay = Double(viewCount - 1) * delay
            let animationTimePerView = totalDuration - totalDelay
            views.enumerated().forEach { args in
                let (offset, view) = args
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(offset) * delay) {
                    animation(view, animationTimePerView)
                }
            }
        }
        phases.append(newPhase)
        return self
    }
    
    public func onComplete(_ complete: @escaping () -> ()) -> Self {
        completeCallback = complete
        return self
    }
    
    public func animate(totalDuration: TimeInterval) {
        prepareCallback?()
        phases.forEach { phase in
            let startTime = phase.start * totalDuration
            let duration = phase.duration * totalDuration
            DispatchQueue.main.asyncAfter(deadline: .now() + startTime) {
                phase.animations(duration)
            }
        }
        if let completeCallback = completeCallback {
            DispatchQueue.main.asyncAfter(deadline: .now() + totalDuration, execute: completeCallback)
        }
    }
    
    private struct AnimationPhase {
        let start: Double
        let duration: Double
        let animations: AnimationCallback
    }
    
    private var phases: [AnimationPhase] = []
    private var prepareCallback: (() -> ())?
    private var completeCallback: (() -> ())?
}
