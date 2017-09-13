class Record
  include ActiveModel::Model

  include RecordFetcher

  attr_accessor :id, :name, :started_at, :ended_at, :regular_span, :early_span
end
