import XCTest

fileprivate func factorial(_ n: Int) -> Int {
    guard n > 1 else { return 1 }
    return factorial(n - 1) * n
}

final class RecursionTests: XCTestCase {
    
    func test_Factorial() {
        let sut = factorial
        
        XCTAssertEqual(sut(3), 6)
    }
}
