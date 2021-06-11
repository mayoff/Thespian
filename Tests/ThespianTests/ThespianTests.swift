import XCTest

actor Thespian {
    var task: Task.Handle<Void, Never>? = nil
    var continuation: CheckedContinuation<Void, Never>? = nil
    var wasStarted = false

    init() { }

    func finishInit(ex: XCTestExpectation) {
        task = async {
            print("\(self) \(#function) async \(wasStarted)")
            if !wasStarted {
                await withCheckedContinuation {
                    continuation = $0
                }
            }

            print("\(self) fulfulling")
            ex.fulfill()
        }
    }

    func start() {
        print("\(self) \(#function) \(wasStarted) \(String(describing: continuation))")
        wasStarted = true
        if let continuation = continuation {
            self.continuation = nil
            continuation.resume()
        }
    }
}

class ThespianTests: XCTestCase {

    func testAsyncDetached() throws {
        let ex = expectation(description: "blerg")

        let thespian = Thespian()
        print("thespian created")
        async {
            await thespian.finishInit(ex: ex)
            print("starting thespian")
            await thespian.start()
        }

        waitForExpectations(timeout: 10)

        withExtendedLifetime(thespian) { }
    }

}

