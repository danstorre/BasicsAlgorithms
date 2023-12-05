//
//  QuickSort.swift
//  Algorithms-BasicsTests
//
//  Created by Daniel Torres on 12/4/23.
//

import XCTest

fileprivate func quickSort(sort array: [Int]) -> [Int] {
    if array.count < 2 {
        return array
    }
    let pivotIndex = array.endIndex / 2
    let pivot = array[pivotIndex]
    let leftSide = array.enumerated().filter { index, item in
        guard index != pivotIndex else { return false }
        return pivot > item
    }.map { $1 }

    let rightSide = array.enumerated().filter { index, item in
        guard index != pivotIndex else { return false }
        return pivot < item
    }.map { $1 }
    
    return quickSort(sort: leftSide) + [pivot] + quickSort(sort: rightSide)
}

final class QuickSortTests: XCTestCase {

    func test_quicksort_deliversArraySorted() {
        let samples = [
            (array: [Int](), result: [Int]()),
            (array: [2,1], result: [1,2]),
            (array: [3,2,1], result: [1,2,3]),
            (array: [4,3,2,1], result: [1,2,3,4]),
        ]
        samples.forEach { sample in
            XCTAssertEqual(quickSort(sort: sample.array), sample.result)
        }
    }

}
