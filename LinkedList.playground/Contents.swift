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

    public func node(atIndex index: Int) -> Node? {
        if index == 0 {
            return head ?? nil
        } else {
            var node = head?.next
            for _ in 1..<index {
                node = node?.next
                if node == nil { break }
            }
            return node ?? nil
        }
    }

    public func insert(value: T, atIndex index: Int) {
        let newNode = Node(value: value)
        if index == 0 {
            newNode.next = head
            head?.previous = newNode
            head = newNode
        } else {
            let prev = node(atIndex: index - 1)
            let next = prev?.next

            newNode.previous = prev
            newNode.next = next

            prev?.next = newNode
            next?.previous = newNode
        }
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

newLL.node(atIndex: 0)?.value
newLL.node(atIndex: 100)?.value
newLL.insert(value: "newOne", atIndex: 1)
newLL.insert(value: "newOne", atIndex: 2)
newLL.print
