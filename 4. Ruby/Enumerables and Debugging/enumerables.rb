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
end
