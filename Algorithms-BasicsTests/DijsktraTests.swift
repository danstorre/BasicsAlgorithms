import XCTest

fileprivate typealias NodeGraph = [String : Int]
fileprivate typealias Graph = [String: NodeGraph]
fileprivate typealias Node = String
fileprivate typealias CostsTable = [String: Int]
fileprivate typealias ParentsTable = [String: String]

fileprivate class Dijsktra {
    private let graph: Graph
    private var processedNodes: [Node] = []
    
    init(graph: Graph) {
        self.graph = graph
    }
    
    func getShortestPath(from startNode: Node, to finishNode: Node) -> (path: [String], weight: Int) {
        guard let startGraph = graph[startNode] else {
            return ([], 0)
        }
        
        var costs = getCostsTable(startGraph: startGraph, startNode: startNode)
        var parents = getParentsTable(from: startGraph, parent: startNode)
        
        while let currentNode = getLowestCostNode(from: costs, processedNodes: processedNodes) {
            let currentNodeCost = costs[currentNode]!
            
            for neighbor in graph[currentNode]!.keys {
                let newCost = currentNodeCost + graph[currentNode]![neighbor]!
                
                if newCost < costs[neighbor]! {
                    costs[neighbor] = newCost
                    parents[neighbor] = currentNode
                }
            }
            
            processedNodes.append(currentNode)
        }
        
        return (getPath(from: startNode, to: finishNode, parents: parents), costs[finishNode]!)
    }
    
    private func getPath(from: Node, to: Node, parents: ParentsTable) -> [Node] {
        guard let parent = parents[to], parent != from else {
            return [from] + [to]
        }
        
        return getPath(from: from, to: parent, parents: parents) + [to]
    }
    
    private func getLowestCostNode(from costsTable: CostsTable, processedNodes: [Node]) -> Node? {
        let nodes = costsTable.keys
        
        var lowestCostNode: (cost: Int, node: Node)?
        for node in nodes {
            let nodeCost = costsTable[node]!
            guard !processedNodes.contains(node) else {
                continue
            }
            
            guard lowestCostNode != nil else {
                lowestCostNode = (nodeCost, node)
                continue
            }
            
            if nodeCost < lowestCostNode!.cost {
                lowestCostNode = (nodeCost, node)
            }
        }
         
        return lowestCostNode?.node
    }
    
    private func getCostsTable(startGraph: NodeGraph, startNode: Node) -> CostsTable {
        let neighborNodes = startGraph.keys
        var costsTable = [String: Int]()
        
        graph.keys.filter({ $0 != startNode }) .forEach { node in
            costsTable[node] = Int.max
        }
        
        neighborNodes.forEach({ (neighbor) in
            costsTable[neighbor] = startGraph[neighbor]
        })
        
        return costsTable
    }
    
    private func getParentsTable(from node: NodeGraph, parent: Node) -> ParentsTable {
        let neighborNodes = node.keys
        var parentsTable = [String: String]()
        
        neighborNodes.forEach({ (neighbor) in
            parentsTable[neighbor] = parent
        })
        
        return parentsTable
    }
}

final class DijsktraTests: XCTestCase {
    func test_disjktra_delivers() {
        var graph = Graph()
        graph["START"] = [
            "A": 6,
            "B": 2
        ]
        graph["A"] = [
            "FIN": 1
        ]
        
        graph["B"] = [
            "A": 3,
            "FIN": 5
        ]
        
        graph["FIN"] = [:]
        
        let sut = Dijsktra(graph: graph)
        
        let (path, weight) = sut.getShortestPath(from: "START", to: "FIN")
        XCTAssertEqual(path, ["START", "B", "A", "FIN"])
        XCTAssertEqual(weight, 6)
    }
}
