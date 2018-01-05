json.set! :age_labels, @by_age.labels
json.set! :by_age, @by_age.data

json.set! :gender_labels, @by_gender.labels
json.set! :by_gender, @by_gender.data

json.set! :month_labels, @by_month.labels
json.set! :by_month, @by_month.data
json.set! :by_month_accumulated, @by_month.data.accumulate(@starting_count)
