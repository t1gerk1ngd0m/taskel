require 'rails_helper'

describe Task do
  describe '#create' do
    it "is invalid without a title" do
      task = build(:task, title: "")
      task.valid?
      expect(task.errors[:title]).to include("を入力してください")
    end
    it "is invalid without a body" do
      task = build(:task, body: "")
      task.valid?
      expect(task.errors[:body]).to include("を入力してください")
    end
    it "is invalid without a status" do
      task = build(:task, status: "")
      task.valid?
      expect(task.errors[:status]).to include("を入力してください")
    end
  end
end