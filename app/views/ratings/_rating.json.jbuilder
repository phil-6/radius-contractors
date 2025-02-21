json.extract! rating, :id, :user_id, :contractor_id, :review, :overall_rating, :value_rating, :communication_rating, :quality_rating, :tidiness_rating, :professionalism_rating, :created_at, :updated_at
json.url rating_url(rating, format: :json)
