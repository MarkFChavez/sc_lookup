require "finder"

RSpec.describe Finder do

  let!(:file_jane) do
    File.read File.join("spec", "fixtures", "clients-with-keyword-jane.json")
  end

  let!(:file_mark) do
    File.read File.join("spec", "fixtures", "clients-with-keyword-mark.json")
  end

  let!(:file_with_duplicate_emails) do
    File.read File.join("spec", "fixtures", "clients-with-duplicate-emails.json")
  end

  describe ".search!" do
    it "returns the records matching the search keyword" do
      clients = described_class.search!(file_jane, "i-am-not-in-the-file")
      expect(clients.size).to eq 0

      clients = described_class.search!(file_jane, "jane")
      expect(clients.size).to eq 1

      clients = described_class.search!(file_mark, "jane")
      expect(clients.size).to eq 0

      clients = described_class.search!(file_mark, "mark")
      expect(clients.size).to eq 1
    end
  end

  describe ".clients_with_duplicates!" do
    it "returns the records with matching emails (by default)" do
      clients = described_class.with_duplicates!(file_with_duplicate_emails)
      expect(clients.size).to eq 3
    end
  end

end
