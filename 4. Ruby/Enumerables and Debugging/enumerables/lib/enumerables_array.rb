class Array
  def my_each(&block)
    count = 0
      while count < self.length
        proc.call(self[count])
          count += 1
        end
    return self
  end

  def my_select(&block)
    new_arr = []
    self.my_each do |el|
      new_arr << el if block.call(el) == true
    end
    new_arr
  end

  def my_reject(&block)
    new_arr = []
    self.each { |el| new_arr << el if !block.call(el)}
    new_arr
  end

  def my_any?(&block)
    self.each { |el| return true if block.call(el)}
    false
  end

  def my_all?(&block)
    self.each {|el| return false if !block.call(el)}
    true
  end

  def my_flatten
    flattened = []

    self.each do |el|
      if el.is_a?(Array)
        flattened += el.my_flatten
      else
        flattened << el
      end
    end
      flattened
  end

  def my_zip(*args)
    new_arr = Array.new(self.length) {Array.new(args.length + 1) {|i| i = nil}}
    
    self.each_with_index do |el, i|
      new_arr[i][0] = el
    end

    args.each_with_index do |el1, idx1|
      cell = idx1 + 1
      el1.each_with_index do |el2, idx2|
        if idx2 < new_arr.length
          new_arr[idx2][cell] = el2
        end
      end
    end

    new_arr
  end

  def my_rotate(num=1)
    new_arr = []
    self.each { |i| new_arr << i}
    num = num % self.length
    num.times {new_arr.push(new_arr.shift)}
    new_arr
  end

  def my_join(str="")
    my_str = ""
    (0...self.length - 1).each do |idx|
      my_str += (self[idx].to_s + str)
    end

    my_str += self[-1].to_s
    my_str
  end

  def my_reverse
    new_arr = []

    self.each do |el|
      new_arr = [el] + new_arr
    end

    new_arr
  end

  def bubble_sort!(&prc)
    prc ||= Proc.new {|a,b| a <=> b}
    sorted = false

    while !sorted
      sorted = true

      (0...self.length-1).each do |idx|
        if prc.call(self[idx], self[idx + 1]) == 1
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          sorted = false
        end
      end
    end
    self
  end

  def bubble_sort(&prc)
    new_arr = self.dup
    new_arr.bubble_sort! {prc}
  end
end

def factors(num)
  new_arr = (1..num).select {|i| num % i == 0}
  new_arr
end

def substrings(string)
  arr = string.split("")
  string_arr = []

  arr.each_with_index do |el1, idx1|
    temp = ""
    temp += el1
    string_arr << temp
    arr.each_with_index do |el2, idx2|
        if idx2 > idx1 
          temp += el2
          string_arr << temp
        end
    end
    
  end
  string_arr
end

def subwords(word, dictionary)
  substrings = substrings(word)
  subwords_arr = []
  substrings.each do |substring| 
    if dictionary.include?(substring) && !subwords_arr.include?(substring)
      subwords_arr << substring
    end
  end
  subwords_arr
end
