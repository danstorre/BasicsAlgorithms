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

fileprivate class Node {
    let item: Int
    var next: Node?
    
    init(item: Int, next: Node? = nil) {
        self.item = item
        self.next = next
    }
}
    
fileprivate func findMaximumNumber(_ current: Node, maximum: Node) -> Int {
    guard let nextNode = current.next else {
        return maximum.item > current.item ? maximum.item : current.item
    }
    return findMaximumNumber(nextNode, maximum: maximum.item > current.item ? maximum : current)
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
    
    func test_findMaximumNumberInList() {
        let sut = findMaximumNumber
        let list = Node(item: 1, next: Node(item: 2, next: Node(item: 3)))
        
        XCTAssertEqual(sut(list, list), 3)
    }
    
    func test_binarySearchRecursive() {
        let array = [0,1,2,3,4,5,6]
        let samples: [((array: [Int], search: Int), expected: Int?)] = [
            ((array: array, search: -1), .none),
            ((array: array, search: 3), 3),
            ((array: array, search: 1), 1),
            ((array: array, search: 5), 5),
            ((array: array, search: 4), 4),
            ((array: array, search: 6), 6),
            ((array: array, search: 2), 2),
            ((array: array, search: 0), 0),
        ]
        
        let sut = binarySearch
        
        samples.forEach { sample in
            let result = sut(sample.0.array, sample.0.search)
            let expected = sample.expected
            XCTAssertEqual(result, expected, "Expected \(String(describing: expected)), got \(String(describing: result))")
        }
    }
}


fileprivate func binarySearch(array: [Int], find search: Int) -> Int? {
    guard !array.isEmpty else { return .none }
    
    let midIndex = array.endIndex / 2
    let midValue = array[midIndex]
    
    if midValue == search {
        return midIndex
    } else if search < midValue {
        return binarySearch(array: Array(array[0..<midIndex]), find: search)
    } else {
        guard let result = binarySearch(array: Array(array[midIndex..<array.endIndex]), find: search) else {
            return .none
        }
        return result + midIndex
    }
}
