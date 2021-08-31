class Array
  def my_each(&proc)
    count = 0
      while count < self.length
        proc.call(self[count])
          count += 1
        end
    return self
  end
end

