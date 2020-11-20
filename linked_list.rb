require 'pry'

class LinkedList
    attr_accessor :name
    def initialize(name="list1")
        @name = name
        @head = nil
        @tail = nil
    end

    def append(value)
        if @head.nil?
            @head = value
            @tail = value
        else
            @tail.next_node = value
            @tail = value
        end
    end

    def prepend(value)
        if @head.nil?
            @head = value
            @tail = value
        else
            value.next_node = @head
            @head = value
        end
    end

    def size
        count = 0
        node = @head
        until node.nil?
            count += 1
            node = node.next_node   
        end
        count
    end

    def head
        return "#{@head.value} > #{@head.next_node}"
    end

    def tail
        "#{@tail.value} > nil"
    end

    def at(index)
        return "Error: node not present" if index >= self.size
        node = index_finder(index)
        return "Error: list is empty" if node.nil?
        node.value
    end

    def pop
        return "List empty" if self.size == 0
        new_tail = index_finder(self.size - 2)
        new_tail.next_node = nil
        @tail = new_tail
        'popped'
    end

    def contains?(value)
        node = @head
        until node.nil?
            return true if node.value == value
            node = node.next_node
        end
        false
    end

    def find(value)
        node = @head
        index = 0
        until node.nil?
            return index if node.value == value
            node = node.next_node
            index += 1
        end
        nil
    end

    def to_s
        node = @head
        string = ''
        until node.nil?
            string << "( #{node.value} ) -> "
            node = node.next_node
        end
        string << 'nil'
    end

    def insert_at(value, index)
        return puts "Error: list empty" if @head.nil?
        if index == 0
            self.prepend(value)
        elsif index > self.size-1
            self.append(value)
        else
            prev_node = index_finder(index-1)
            node = index_finder(index)
            value.next_node = node
            prev_node.next_node = value
        end
    end

    def remove_at(index)
        if index == 0
            @head = @head.next_node
        elsif index >= self.size
            self.pop
        else
            node = index_finder(index-1)
            node.next_node = node.next_node.next_node
        end
    end

    # protected

    def index_finder(index)
        position = 0 
        node = @head
        until position == index
            node = node.next_node
            position += 1
        end
        node
    end

end

class Node
    attr_accessor :value, :next_node
    def initialize(value=nil)
        @value = value
        @next_node = nil
    end
end

node_1 = Node.new("a")
node_2 = Node.new("1")
node_3 = Node.new("hello")
node_4 = Node.new('world')
node_5 = Node.new('start')

node_6 = Node.new('delete_me')
node_7 = Node.new('delete me too')
node_8 = Node.new('delete me as well')

list = LinkedList.new("test")

list.insert_at(node_2, 3)
p list.at(1)
p list.size
list.append(node_1)
list.append(node_2)
list.append(node_3)
list.append(node_4)
list.prepend(node_5)

p list.size
p list.head
p list.tail
p list.at(2)
p list.contains?("a")
p list.contains?("start")
p list.contains?("b")
p list.find("a")
p list.find("hello")
p list.to_s
list.insert_at(node_6, 5)
p list.size
p list.to_s
list.insert_at(node_7, 2)
p list.pop
p list.size
p list.to_s
list.insert_at(node_6, 0)
p list.size
p list.to_s
list.insert_at(node_8, 9)
p list.size
p list.to_s
list.remove_at(8)
p list.to_s
list.remove_at(3)
p list.to_s
list.remove_at(0)
p list.to_s