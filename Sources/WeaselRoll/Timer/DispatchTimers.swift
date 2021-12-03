import Dispatch

public enum DispatchTimers {
    public static func start(
        flags: DispatchSource.TimerFlags = [],
        queue: DispatchQueue?,
        deadline: DispatchTime,
        handler: @escaping () -> Void
    ) -> DispatchSourceTimer {
        let timer = DispatchSource.makeTimerSource(flags: flags, queue: queue)
        timer.schedule(deadline: deadline)
        timer.setEventHandler(handler: handler)
        timer.resume()
        return timer
    }
}
