{-# LANGUAGE ForeignFunctionInterface #-}
module Foo where

#include "foo.h"

import Foreign hiding (unsafePerformIO)
import Foreign.Marshal.Array
import Foreign.Storable
import System.IO.Unsafe (unsafePerformIO)

data Foo = Foo
    { fooBar  :: #{type uint32_t}
    , fooBaz  :: #{type int8_t}
    , fooQuux :: [#{type int8_t}]
    } deriving (Eq, Show)

instance Storable Foo where
    sizeOf _    = #{size foo_t}
    alignment _ = alignment (undefined :: Word32)

    peek ptr = do
        r1 <- #{peek foo_t, bar} ptr
        r2 <- #{peek foo_t, baz} ptr
        r3 <- peekArray 4 $ #{ptr foo_t, quux} ptr
        return (Foo r1 r2 r3)

    poke ptr (Foo r1 r2 r3) = do
        #{poke foo_t, bar} ptr r1
        #{poke foo_t, baz} ptr r2
        pokeArray (#{ptr foo_t, quux} ptr) r3

type Buffer = [Word8]

foreign import ccall "foo.h serialise"
    c_serialise :: Ptr Foo -> Ptr Word8 -> IO Int
foreign import ccall "foo.h deserialise"
    c_deserialise :: Ptr Word8 -> Ptr Foo -> IO Int

serialise :: Foo -> Buffer
serialise foo = unsafePerformIO $ with foo $
    \foo_ptr -> allocaArray (sizeOf foo) $
    \buf_ptr -> do
        sz <- c_serialise foo_ptr buf_ptr
        peekArray sz buf_ptr

deserialise :: Buffer -> Foo
deserialise buf = unsafePerformIO $ withArray buf $
    \buf_ptr -> allocaBytes (sizeOf (undefined :: Foo)) $
    \foo_ptr -> do
        _ <- c_deserialise buf_ptr foo_ptr
        peek foo_ptr
