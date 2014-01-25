module Main where

import Foo

import Test.QuickCheck

instance Arbitrary Foo where
    arbitrary = do
        foobar  <- arbitrary
        foobaz  <- arbitrary
        fooquux <- vector 4
        return (Foo foobar foobaz fooquux)

prop_roundtrip = property $
    \foo -> foo == deserialise (serialise foo)

main = quickCheck prop_roundtrip
