import Dispatch

extension DispatchSource {
    public static func startTimer(
        flags: TimerFlags = [],
        queue: DispatchQueue?,
        deadline: DispatchTime,
        handler: @escaping () -> Void) ->
        DispatchSourceTimer
    {
        let timer = DispatchSource.makeTimerSource(flags: flags, queue: queue)
        timer.schedule(deadline: deadline)
        timer.setEventHandler(handler: handler)
        timer.resume()
        return timer
    }
}
