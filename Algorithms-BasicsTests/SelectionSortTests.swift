@testable import Algorithms_Basics
import XCTest

enum SelectionSort {
    static func sort(_ array: [Int]) -> [Int] {
        var originalCopy = array
        var newArray = [Int]()
        
        for _ in 0..<originalCopy.count {
            let smallestIndex = Self.findSmallest(originalCopy)
            newArray.append(array[smallestIndex])
            originalCopy.remove(at: smallestIndex)
        }
        
        return newArray
    }
    
    static func findSmallest(_ array: [Int]) -> Int {
        var smallestIndex = 0
        for i in 1..<array.count {
            if array[i] < array[smallestIndex] {
                smallestIndex = i
            }
        }
        return smallestIndex
    }
}

final class SelectionSortTests: XCTestCase {
    func test_sort_shouldDeliverSortedArray() throws {
        let samples: [(unsortedArray: [Int], expected: [Int])] = [
            (unsortedArray: [], expected: []),
            (unsortedArray: [0], expected: [0]),
            (unsortedArray: [1,0], expected: [0,1]),
            (unsortedArray: [3,2,1,0], expected: [0,1,2,3]),
        ]
        samples.forEach { (unsortedArray, expectedArray) in
            let sut: (([Int]) -> [Int]) = SelectionSort.sort
            
            let sortedArray = sut(unsortedArray)
            
            XCTAssertEqual(sortedArray, expectedArray, "expected \(expectedArray) but got \(sortedArray)")
        }
    }
}
