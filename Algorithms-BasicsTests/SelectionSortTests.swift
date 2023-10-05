@testable import Algorithms_Basics
import XCTest

enum SelectionSort {
    static func sort(_ array: [Int]) -> [Int] {
        []
    }
}

final class SelectionSortTests: XCTestCase {
    func test_sort_shouldDeliverSortedArray() throws {
        let samples: [(unsortedArray: [Int], expected: [Int])] = [
            (unsortedArray: [], expected: [])
        ]
        samples.forEach { (unsortedArray, expectedArray) in
            let sut: (([Int]) -> [Int]) = SelectionSort.sort
            
            let sortedArray = sut(unsortedArray)
            
            XCTAssertEqual(sortedArray, expectedArray, "expected \(expectedArray) but got \(sortedArray)")
        }
    }
}
