class Employee
  attr_accessor :name, :title, :salary
  attr_reader :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    self.boss = boss
  end

  def boss=(boss)
    boss.employees -= [self] unless boss.nil?
    @boss = boss
    boss.employees += [self] unless boss.nil?
  end

  def bonus(multiplier)
    salary * multiplier
  end
end
