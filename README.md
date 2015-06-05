# decimalInfinite
This is the JSONiq implementation of the decimalInfinite Encoding Service. It's just 130 lines of code.

# Usage

Go to [http://decimalinfinite.28.io/encode.jq?d=100&d=3.1415926535](http://decimalinfinite.28.io/encode.jq?d=100&d=3.1415926535)

It returns:

    {
      "100" : "10110000100", 
      "3.1415926535" : "1010001101000110101001010000010100011010111110100"
    }
    
Change the d parameter at will.

That's it!

# Testing validity

[http://decimalinfinite.28.io/test-encode.jq?range=1000&precision=0.1](http://decimalinfinite.28.io/test-encode.jq?range=1000&precision=0.1)

This tests the order preservation of the decimals -100, -99.9, -99.8..., 99.9, 100. You can adjust the range and precision at will.
