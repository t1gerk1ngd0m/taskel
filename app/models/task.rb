class Task < ApplicationRecord
    enum status: { waiting: 0, working: 1, finished: 2}
end
