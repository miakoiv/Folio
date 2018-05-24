xml.instruct!
xml.person do
  xml.identification @person.identification
  xml.lastname @person.last_name
  xml.firstnames @person.first_names
  xml.date_of_birth @person.date_of_birth
  xml.gender @person.gender
  xml.place_of_residence @person.municipality.to_s
  xml.type_of_residence @person.accommodation
  xml.language @person.language
  xml.nationality @person.nationality
  xml.education @person.education_to_s
  xml.disabilities @person.disabilities
  xml.contact_information do
    xml.email_address @person.email
    xml.phone_number @person.phone
    xml.street_address @person.address
    xml.postal_code @person.postcode.code
    xml.postal_address @person.postcode.name
  end
  xml.notes @person.notes
  xml.related_people do
    @person.relationships.each do |relationship|
      xml.related_person legal_guardian: relationship.legal_guardian? do
        xml.relationship relationship.relation.to_s
        xml.lastname relationship.parent.last_name
        xml.firstnames relationship.parent.first_names
      end
    end
  end
  xml.customer_records do
    @person.customers.at(current_unit).each do |customer|
      xml.customer_record do
        xml.timestamp customer.created_at
        xml.status customer.status
        xml.referring_party customer.referrer_to_s
        xml.personnel do
          customer.contacts.each do |contact|
            xml.contact_person contact
          end
        end
        xml.scheduled_events do
          customer.events.each do |event|
            xml.scheduled_event do
              xml.type event.event_type
              xml.title event.title
              xml.start_time event.starts_at
              xml.duration event.duration / 60, unit: 'minutes'
            end
          end
        end
        xml.milestones do
          customer.steps.each do |step|
            xml.milestone do
              xml.date step.reached_at
              xml.description step.milestone.to_s
              xml.notes step.notes
            end
          end
        end
        xml.internal_data do
          xml.notes do
            customer.notes.each do |note|
              xml.note do
                xml.timestamp note.created_at
                xml.title note.title
                xml.html do
                  xml.cdata! note.content
                end
              end
            end
          end
          xml.reviews do
            customer.reviews.each do |review|
              xml.review do
                xml.timestamp review.created_at
                xml.title review.title
                xml.html do
                  xml.cdata! review.content
                end
              end
            end
          end
        end
      end
    end
  end
end
