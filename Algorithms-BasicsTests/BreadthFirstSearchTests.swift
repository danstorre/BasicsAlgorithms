//
//  BreadthFirstSearchTests.swift
//  Algorithms-BasicsTests
//
//  Created by Daniel Torres on 1/21/24.
//

import XCTest

fileprivate class Node {
    let name: String
    var next: Node?
    
    init(item: String, next: Node? = nil) {
        self.name = item
        self.next = next
    }
}

fileprivate class Queue {
    var root: Node?
    var last: Node?
    
    init(root: Node?) {
        self.root = root
        self.last = root
    }
    
    func enqueue(node: Node) {
        if last == nil {
            root = node
            last = node
            
        } else {
            last?.next = node
            last = node
        }
    }
    
    func dequeue() -> Node? {
        let head = root
        root = root?.next
        return head
    }
}

extension Queue {
    func nextPerson() -> String? {
        dequeue()?.name
    }
}

fileprivate class BreadthFirstSearchMangoSeller {
    private var searchQueue = Queue(root: nil)
    private var searchedPeople = [String]()
    
    func isThereMangoSeller(from graph: [String: [String]], startingFrom person: String) -> String? {
        enqueueConnectionsToSearchOf(person: person, from: graph)
        
        while let nextPerson = searchQueue.nextPerson() {
            if isSeller(nextPerson) {
                return nextPerson
            } else {
                guard !hasBeenSearched(person: nextPerson) else { continue }
                
                enqueueConnectionsToSearchOf(person: nextPerson, from: graph)
            }
        }
        
        return nil
    }
    
    private func enqueueConnectionsToSearchOf(person: String, from graph: [String: [String]]) {
        getConnections(of: person, from: graph).forEach({ connectionPerson in
            searchQueue.enqueue(node: transformToNode(person: connectionPerson))
        })
    }
    
    private func getConnections(of person: String, from graph: [String: [String]]) -> [String] {
        graph[person] ?? []
    }
    
    private func transformToNode(person: String) -> Node {
        Node(item: person, next: nil)
    }
    
    private func reset() {
        searchQueue = Queue(root: nil)
        searchedPeople = [String]()
    }
    
    private func hasBeenSearched(person: String) -> Bool {
        if searchedPeople.contains(person) {
            return true
        } else {
            searchedPeople.append(person)
            return false
        }
    }
    
    private func isSeller(_ name: String) -> Bool {
        return name == "anuj"
    }
}

final class BreadthFirstSearchTests: XCTestCase {

    func test_findShortestPath_inGraph() {
        var graph = [String: [String]]()
        graph["you"] = ["alice", "bob", "claire"]
        graph["bob"] = ["anuj", "peggy"]
        graph["alice"] = ["peggy"]
        graph["claire"] = ["thom", "jonny"]
        graph["anuj"] = []
        graph["peggy"] = []
        graph["thom"] = []
        graph["jonny"] = []
        
        let sut = BreadthFirstSearchMangoSeller()
        
        XCTAssertEqual("anuj", sut.isThereMangoSeller(from: graph, startingFrom: "you"))
    }

}
