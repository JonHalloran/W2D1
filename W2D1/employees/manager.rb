class Manager < Employee
  attr_reader :employees
  def initialize(*args)
    super(*args)
    @employees = []
  end

  def bonus(multiplier)
    multiplier * get_underling_salaries
  end

  def get_underling_salaries
    total = 0
    employees.each do |employee|
      if employee.is_a?(Manager)
        total += employee.get_underling_salaries
      end
      total += employee.salary
    end
    total
  end
end
