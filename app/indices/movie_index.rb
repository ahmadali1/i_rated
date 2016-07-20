ThinkingSphinx::Index.define :movie, with: :active_record, delta: true do

  indexes :name, sortable: true
  indexes description
  indexes genre
  indexes actors.name, as: :actor

  has released_date, sortable: true
  has approved

end
