require 'rails_helper'

describe Task do
  describe '#create' do
    it "is invalid without a title" do
      task = Task.new(title: "", body: "本文", deadline: '2018-06-07', status: 2, file: "0000000" )
      task.valid?
      expect(task.errors[:title]).to include("を入力してください")
    end
    it "is invalid without a body" do
      task = Task.new(title: "タイトル", body: "", deadline: '2018-06-07', status: 2, file: "0000000" )
      task.valid?
      expect(task.errors[:body]).to include("を入力してください")
    end
    it "is invalid without a status" do
      task = Task.new(title: "タイトル", body: "本文", deadline: '2018-06-07', status: "", file: "0000000" )
      task.valid?
      expect(task.errors[:status]).to include("を入力してください")
    end
  end
end