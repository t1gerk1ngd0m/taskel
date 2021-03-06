require 'rails_helper'

describe Task, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe '#create' do
    it "is invalid without a title" do
      task = build(:task, title: "")
      task.valid?
      expect(task.errors[:title]).to include I18n.t('errors.messages.blank')
    end
    it "is invalid without a body" do
      task = build(:task, body: "")
      task.valid?
      expect(task.errors[:body]).to include I18n.t('errors.messages.blank')
    end
    it "is invalid without a status" do
      task = build(:task, status: "")
      task.valid?
      expect(task.errors[:status]).to include I18n.t('errors.messages.blank')
    end
    it "is invalid without a priority" do
      task = build(:task, priority: "")
      task.valid?
      expect(task.errors[:priority]).to include I18n.t('errors.messages.blank')
    end
    it "is valid with a title, body, status, priority" do
      task = build(:task, deadline: "", file: "")
      task.valid?
      expect(task).to be_valid
    end
  end

  describe 'search tasks' do
    # before doでセットした値がなぜか各contextでセットされていないので一旦コメントアウト
    # before do
    #   task1 = create(:task, title: "taska_1", status: 'waiting')
    #   task2 = create(:task, title: "task_2", status: 'working')
    #   task3 = create(:task, title: "task_3", status: 'finished')
    #   task4 = create(:task, title: "taskb_4", status: 'finished')
    #   task5 = create(:task, title: "task_5", status: 'working')
    # end

    context "when a match is found searched with title" do
      it "returns tasks that match the search term" do
        task1 = create(:task, title: "taska_1", status: 'waiting')
        task2 = create(:task, title: "task_2", status: 'working')
        task3 = create(:task, title: "task_3", status: 'finished')
        task4 = create(:task, title: "taskb_4", status: 'finished')
        task5 = create(:task, title: "task_5", status: 'working')
        params = { title: "task_", status: '' }
        expect(Task.search(params)).to include(task2, task3, task5)
      end
    end

    context "when no match is found searched with title" do
      it "returns an empty collection" do
        task1 = create(:task, title: "taska_1", status: 'waiting')
        task2 = create(:task, title: "task_2", status: 'working')
        task3 = create(:task, title: "task_3", status: 'finished')
        task4 = create(:task, title: "taskb_4", status: 'finished')
        task5 = create(:task, title: "task_5", status: 'working')
        params = { title: "taskc", status: '' }
        expect(Task.search(params)).to be_empty
      end
    end

    context "when a match is found searched with status" do
      it "returns tasks that match the search term" do
        task1 = create(:task, title: "taska_1", status: 'waiting')
        task2 = create(:task, title: "task_2", status: 'working')
        task3 = create(:task, title: "task_3", status: 'finished')
        task4 = create(:task, title: "taskb_4", status: 'finished')
        task5 = create(:task, title: "task_5", status: 'working')
        params = { title: "sk_", status: "#{Task.statuses[:working]}" }
        expect(Task.search(params)).to include(task2, task5)
      end
    end

    context "when no match is found searched with status" do
      it "returns an empty collection" do
        task1 = create(:task, title: "taska_1", status: 'waiting')
        task2 = create(:task, title: "task_2", status: 'working')
        task3 = create(:task, title: "task_3", status: 'finished')
        task4 = create(:task, title: "taskb_4", status: 'finished')
        task5 = create(:task, title: "task_5", status: 'working')
        params = { title: "skc_", status: "#{Task.statuses[:finished]}" }
        expect(Task.search(params)).to be_empty
      end
    end

    context "when no match is found searched with status" do
      it "returns all collection" do
        task1 = create(:task, title: "taska_1", status: 'waiting')
        task2 = create(:task, title: "task_2", status: 'working')
        task3 = create(:task, title: "task_3", status: 'finished')
        task4 = create(:task, title: "taskb_4", status: 'finished')
        task5 = create(:task, title: "task_5", status: 'working')
        params = { title: "", status: '' }
        expect(Task.search(params)).to include(task1, task2, task3, task4, task5)
      end
    end
  end
end