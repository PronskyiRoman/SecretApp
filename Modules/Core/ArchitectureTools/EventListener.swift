import Foundation

public final class EventListener<T> {
  private var continuation: AsyncStream<T>.Continuation?
  public lazy var stream: AsyncStream<T> = .finished

  public init() {
    stream = AsyncStream { [weak self] continuation in
      self?.continuation = continuation
    }
  }

  public func yield(with value: T) {
    continuation?.yield(value)
  }
}

public extension EventListener where T == Void {
  func yield() {
    continuation?.yield()
  }
}
