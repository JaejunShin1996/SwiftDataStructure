import UIKit

public class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    var previous: LinkedListNode?

    public init(value: T) {
        self.value = value
    }
}

public class LinkedList<T> {
    public typealias Node = LinkedListNode<T>

    private var head: Node?

    public var first: Node? {
        return head
    }

    public var last: Node? {
        guard var node = head else { return nil }

        while let next = node.next {
            node = next
        }

        return node
    }

    public var count: Int {
        guard var node = head else { return 0 }
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }

    public var print: String {
        var stringArray = "["
        guard var node = head else { return "[]" }
        while let next = node.next {
            stringArray += "\(node.value), "
            node = next
        }
        stringArray += "\(node.value)"
        return stringArray + "]"
    }

    public func append(value: T) {
        let newNode = Node(value: value)
        if let lastNode = last {
            // at least one node
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }

    public func node(atIndex index: Int) -> Node {
        if index == 0 {
            return head!
        } else {
            var node = head?.next
            for _ in 1 ..< index {
                node = node?.next
                if node == nil { break }
            }
            return node!
        }
    }

    public func insert(value: T, atIndex index: Int) {
        let node = Node(value: value)
        if index == 0 {
            node.next = head
            head?.previous = node
            head = node
        } else {
            let prev = self.node(atIndex: index - 1)
            let next = prev.next

            node.previous = prev
            node.next = next

            prev.next = node
            next?.previous = node
        }
    }

    public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next

        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev

        node.previous = nil
        node.next = nil

        return node.value
    }

    public func removeAt(index: Int) -> T {
        let nodeToRemove = node(atIndex: index)
        return remove(node: nodeToRemove)
    }
}

let newLL = LinkedList<String>()
newLL.append(value: "hello")
newLL.count
newLL.append(value: "jae")
newLL.append(value: "asdf")
newLL.count
print(newLL.first!.value)
print(newLL.last!.value)

newLL.node(atIndex: 0).value
newLL.node(atIndex: 100).value
newLL.insert(value: "newOne", atIndex: 1)
newLL.insert(value: "newOne", atIndex: 2)
newLL.print

newLL.removeAt(index: 0)
newLL.print
