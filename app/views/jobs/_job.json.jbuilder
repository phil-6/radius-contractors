json.extract! job, :id, :user_id, :contractor_id, :description, :state, :start_date, :end_date, :review, :created_at, :updated_at
json.url job_url(job, format: :json)
