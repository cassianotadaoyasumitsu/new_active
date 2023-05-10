class Job < ApplicationRecord
  JOBS = Job.pluck(:title)

  after_commit do
    # update the JOBS constant after a new job is saved
    self.class::JOBS.replace(self.class.pluck(:title))
  end
end
