import XCTest

fileprivate func factorial(_ n: Int) -> Int {
    guard n > 1 else { return 1 }
    return factorial(n - 1) * n
}

fileprivate func sumRecursively(_ array: [Int]) -> Int {
    guard !array.isEmpty, let head = array.first else { return 0 }
    return head + sumRecursively(Array(array.dropFirst()))
}

fileprivate func countItems(_ node: Node) -> Int {
    guard let next = node.next else { return 0 }
    return node.item + countItems(next)
}

class Node {
    let item: Int
    var next: Node?
    
    init(item: Int, next: Node? = nil) {
        self.item = item
        self.next = next
    }
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
    
    func test_countItemsInList() {
        let sut = countItems
        let list = Node(item: 1, next: Node(item: 2, next: Node(item: 3)))
        
        XCTAssertEqual(sut(list), 3)
    }
}
