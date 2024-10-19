# BitX CSV Statement Parser

A basic parser for [BitX](https://bitx.co.za) CSV statements.

The script is written in [Ruby](https://www.ruby-lang.org) and only uses standard libraries (no additional gems are required).

Usage (assuming an input CSV file with path `data/btc.csv`):

```sh
ruby process.rb data/btc.csv
```

Sample output:

```
Buy transaction count: REDACTED
ZAR spent: REDACTED
BTC bought: REDACTED
Average ZAR/BTC: REDACTED
```
