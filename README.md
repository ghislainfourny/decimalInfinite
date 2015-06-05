# decimalInfinite
This is the JSONiq implementation of the decimalInfinite Encoding Service

# Usage

Go to [http://decimalinfinite.28.io/encode.jq?d=100&d=3.1415926535](http://decimalinfinite.28.io/encode.jq?d=100&d=3.1415926535)

It returns:

    {
      "100" : "10110000100", 
      "3.1415926535" : "1010001101000110101001010000010100011010111110100"
    }
    
Change the d parameter at will.

That's it!
