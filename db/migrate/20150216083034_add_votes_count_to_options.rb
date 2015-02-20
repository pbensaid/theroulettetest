class AddVotesCountToOptions < ActiveRecord::Migration
  def change
    add_column :options, :votes_count, :integer, :default => 0

    Option.reset_column_information
    Option.all.each do |o|
      Option.update_counters o.id, :votes_count => o.votes.length
    end
  end
end