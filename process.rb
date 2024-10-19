require 'CSV'

# file name of CSV to process
filename = ARGV[0]

if filename.nil?
    abort("File name to CSV must be provided as command line argument")
end

csv_rows = CSV.read(filename)
csv_header_row = csv_rows.pop
csv_data_rows = csv_rows.reverse

class Transaction
    attr_accessor :description

    def initialize(csv_row)
        # "Account"
        @account_number = csv_row[0]
        # "Row"
        @row_number = csv_row[1].to_s
        # "Timestamp"
        @timestamp = csv_row[2]
        # "Description"
        @description = csv_row[3]
        # "Currency"
        @currency = csv_row[4]
        # "Balance Delta"
        @balance_delta = csv_row[5].to_f
        # "Available Delta"
        @available_delta = csv_row[6].to_f
        # "Balance"
        @balance = csv_row[7].to_f
        # "Available"
        @available = csv_row[8].to_f
    end

    def type
        # TODO: implement
        return :buy if @description.start_with? 'Bought '
        return :sell if @description.start_with? 'Sold '
    end

end

btc_bought = 0
zar_spent = 0
buy_transaction_count = 0

csv_data_rows.each do |row|
    transaction = Transaction.new(row)

    if transaction.type == :buy
        buy_transaction_count += 1
        parts = transaction.description.split
        btc_amount = parts[1].to_f
        btc_zar_rate = parts[4].gsub(/,/, '').to_f

        btc_bought += btc_amount
        zar_spent += btc_amount * btc_zar_rate
    end

    if transaction.type == :sell
    end

end

puts "Buy transaction count: #{buy_transaction_count}"
puts "ZAR spent: #{zar_spent}"
puts "BTC bought: #{btc_bought}"
puts "Average ZAR/BTC: #{zar_spent/btc_bought}"
