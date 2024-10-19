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
        # "Wallet ID"
        @account_number = csv_row[0]
        # "Row"
        @row_number = csv_row[1].to_s
        # "Timestamp (UTC)"
        @timestamp = csv_row[2]
        # "Description"
        @description = csv_row[3]
        # "Currency"
        @currency = csv_row[4]
        # "Balance delta"
        @balance_delta = csv_row[5].to_f
        # "Available balance delta"
        @available_delta = csv_row[6].to_f
        # "Balance"
        @balance = csv_row[7].to_f
        # "Available balance"
        @available = csv_row[8].to_f
        # "Cryptocurrency transaction ID"
        @transaction_id = csv_row[9]
        # "Cryptocurrency address"
        @address = csv_row[10]
        # "Value currency"
        @value_currency = csv_row[11]
        # "Value amount"
        @value_amount = csv_row[12]
        # "Reference"
        @reference = csv_row[13]
    end

    def type
        # TODO: support cryptocurrencies and fiat currency pairs other than BTC and ZAR
        
        # sample input for description: "Bought 1.23 BTC/ZAR @ 123,456"
        return :buy if @description.match(/Bought [\d\.]+ BTC\/ZAR/)
        # return :buy if @description.start_with? 'Bought '
        
        return :sell if @description.start_with? 'Sold BTC'
        
        return nil
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
        # TODO: implement
    end

end

# TODO: improve to handle cryptocurrencies, fiat currencires and pairs other than BTC/ZAR
puts "BTC buy transaction count: #{buy_transaction_count}"
puts "ZAR spent: #{'%.2f' % zar_spent}"
puts "BTC bought: #{btc_bought}"
puts "Average ZAR/BTC: #{'%.2f' % (zar_spent/btc_bought)}"
