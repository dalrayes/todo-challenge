class Task
  attr_reader :status
  def initialize(first, second)
    @status = 'incomplete'
  end

  def mark_as_complete!
    @status = 'complete'
    self
  end

  def mark_as_incomplete!
    @status = 'incomplete'
    self
  end

  def complete?
    if @status == 'incomplete'
      false
    else
      true
    end
  end
end

class Todo
  attr_reader :title, :tasks

  def initialize(this)
    @title = this
    @tasks = []
  end

  def add_task(task)
    @tasks << task
  end

  def complete_all!
    @tasks.each { |task| task.mark_as_complete!}
  end

  def complete?
    @tasks.each do |task|
      if task.complete? == false
        return false
      end
    end
    true
  end

  def completed_tasks
    @tasks.select { |task| task if task.complete?}
  end


  def incomplete_tasks
    @tasks.select { |task| task unless task.complete?}
  end


end















