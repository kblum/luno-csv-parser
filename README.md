# Luno CSV Statement Parser

A basic parser script for [Luno](https://www.luno.com) (formerly [BitX](https://bitx.co.za)) CSV statements.

The script currently only supports BTC/ZAR pairs.

The script is written in [Ruby](https://www.ruby-lang.org) and only uses standard libraries (no additional gems are required).

Usage (assuming an input CSV file with path `data/btc.csv`):

```sh
ruby process.rb data/btc.csv
```

Sample output:

```
BTC buy transaction count: REDACTED
ZAR spent: REDACTED
BTC bought: REDACTED
Average ZAR/BTC: REDACTED
```
