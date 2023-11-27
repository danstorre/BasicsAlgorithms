import XCTest

fileprivate func factorial(_ n: Int) -> Int {
    guard n > 1 else { return 1 }
    return factorial(n - 1) * n
}

fileprivate func sumRecursively(_ array: [Int]) -> Int {
    guard !array.isEmpty, let head = array.first else { return 0 }
    return head + sumRecursively(Array(array.dropFirst()))
}

final class RecursionTests: XCTestCase {
    
    func test_Factorial() {
        let sut = factorial
        
        XCTAssertEqual(sut(3), 6)
    }
    
    func test_sumArray() {
        let sut = sumRecursively
        let array = [1,2,3,4]
        
        XCTAssertEqual(sut(array), 10)
    }
}
