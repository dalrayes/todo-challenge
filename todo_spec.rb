require 'time'
require 'date'
require_relative 'todo'


describe "task" do
  let(:task) { Task.new("My Title", "my description") }

  describe "#initialize" do
    it "creates a task object" do
      expect(task).to be_an_instance_of(Task)
    end

    it "takes at least two args" do
        expect{ Task.new }.to raise_error(ArgumentError)
    end

    it "has a default status of Incomplete" do
      expect(task.status).to eq("incomplete")
    end

    # it "sets created_at in initialize" do
    #   Time.stub!(:now).and_return(Time.mktime(2015, 02, 03))
    #   expect(task.created_at).to
    # end
  end

  describe "#mark_as_complete!" do
    it "sets status to complete" do
      expect{task.mark_as_complete!}.to change{task.status}
    end
  end

  describe "#mark_as_incomplete!" do
    it "sets status to incomplete" do
      task.mark_as_complete!
      expect{task.mark_as_incomplete!}.to change{task.status}
    end
  end

  describe "#complete?" do
    it "returns whether task is complete" do
      expect(task.complete?).to be_falsey
    end
  end

end

describe "todo list" do
  let(:todo) { Todo.new("My title") }
  let(:complete_task) { Task.new("title", "description").mark_as_complete! }
  let(:incomplete_task) {  Task.new("title", "description") }

  describe "#initialize" do

    it "creates a Todo" do
      expect(todo).to be_an_instance_of(Todo)
    end

    it "sets title" do
      expect(todo.title).to eq("My title")
    end

    it "has tasks" do
      expect(todo.tasks).to be_an_instance_of(Array)
    end
  end

  describe "#add_task" do
    it "takes a parameter" do
      expect{ todo.add_task }.to raise_error
    end

    it "adds to task list" do
      fake_task = double(Task, title: "my fake task")
      expect{ todo.add_task(fake_task) }.to change{ todo.tasks.size }.by(1)
    end
  end

  describe "#complete_all!" do
    # before {
    #   fake1 = instance_double("Task", :status => "incomplete")
    #   fake2 = instance_double("Task", :status => "incomplete")
    #   fake3 = instance_double("Task", :status => "incomplete")
    #   todo.add_task(fake1)
    #   todo.add_task(fake2)
    #   todo.add_task(fake3)
    # }

    let(:fake1) {Task.new('blah', 'blah')}
    let(:fake2) {Task.new('blahblah', 'blahblah')}
    let(:fake3) {Task.new('blahblahblah', 'blahblahblah')}

    before do
      todo.add_task(fake1)
      todo.add_task(fake2)
      todo.add_task(fake3)
    end

    it "marks first task as complete" do
      expect{ todo.complete_all! }.to change { fake1.status }
    end

    it "marks second task as complete" do
      expect{ todo.complete_all! }.to change { fake2.status }
    end

    it "marks last task as complete" do
      expect{ todo.complete_all! }.to change { fake3.status }
    end
  end

  describe "#complete?" do

    it "returns true when all tasks have been completed" do

      todo.add_task(complete_task)
      expect(todo.complete?).to be_truthy
    end

    it "returns false when not all tasks are complete" do
      todo.add_task(incomplete_task)
      expect(todo.complete?).to be_falsey
    end
  end

  describe "#completed_tasks" do


    it "returns array of completed tasks" do

      todo.add_task(complete_task)
      todo.add_task(incomplete_task)
      expect(todo.completed_tasks).to eq([complete_task])
    end
  end

  describe "#incomplete_tasks" do

    it "returns array of incomplete tasks" do

      todo.add_task(complete_task)
      todo.add_task(incomplete_task)
      expect(todo.incomplete_tasks).to eq([incomplete_task])
    end
  end

end
