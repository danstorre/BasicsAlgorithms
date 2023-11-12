@testable import Algorithms_Basics
import XCTest

enum SelectionSort {
    static func sort(_ array: inout [Int]) {
        
    }
}

final class SelectionSortTests: XCTestCase {
    func test_sort_shouldDeliverSortedArray() throws {
        let samples: [(unsortedArray: [Int], expected: [Int])] = [
            (unsortedArray: [], expected: []),
            (unsortedArray: [0], expected: [0]),
//            (unsortedArray: [1,0], expected: [0,1]),
//            (unsortedArray: [3,2,1,0], expected: [0,1,2,3]),
        ]
        samples.forEach { (unsortedArray, expectedArray) in
            var unsortedArray = unsortedArray
            let sut: ((inout [Int]) -> Void) = SelectionSort.sort
            
            sut(&unsortedArray)
            
            XCTAssertEqual(unsortedArray, expectedArray, "expected \(expectedArray) but got \(unsortedArray)")
        }
    }
}
