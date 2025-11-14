class Finder

  def self.search_by_email!(file, keyword, search_by = "full_name")
    clients = JSON.parse(file).select do |hash|
      hash[search_by].downcase.include?(keyword.downcase)
    end

    clients
  end

  def self.clients_with_duplicates(file, by = "email")
    grouped_data = JSON.parse(file).group_by { |hash| hash[by] }
    duplicate_records = grouped_data.select { |_email, how_many| how_many.size > 1 }.
      values.
      flatten

    duplicate_records
  end

end
