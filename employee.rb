class Employee
  attr_reader :salary, :name
  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_reader :employees
  def initialize(name, title, salary, boss, *employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    total = 0
    list = employee_list

    list.each {|employee| total += employee.salary}
    total *= multiplier
  end

  def employee_list
    result = []
    @employees.each do |employee|
      if !employee.is_a?(Manager)
        result << employee
      else
        result << employee
        result += employee.employee_list
      end
    end
    result
  end
end

david = Employee.new("David", "TA", 10_000, "Darren")
shawna = Employee.new("Shawna", "TA", 12_000, "Darren")
darren = Manager.new("Darren", "TA Manager", 78_000, "Ned", david, shawna)
ned = Manager.new("Ned", "Founder", 1_000_000, nil, darren)

p ned.bonus(5) # => 500_000
# p darren.bonus(4) # => 88_000
# p david.bonus(3) # => 30_000
