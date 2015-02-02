module Sound.MikMod.Types where

import Foreign.Ptr
import Foreign.C.Types
import System.IO
import Data.Word (Word8)

import Sound.MikMod.Synonyms
import Sound.MikMod.Flags

-- | MikMod distinguishes module channels from voices. Sound effects and music
-- both work by playing samples on voices. At most one sample can play on a
-- voice at a time. Operations on the voice level take a voice number which you
-- can get using mikmodGetChannelVoice.
newtype Voice = Voice { marshalVoice :: SBYTE }
  deriving (Eq, Ord, Show)

-- | Operations that manipulate muting of multiple channels use one of two
-- interpretations of the specified channge range. MuteExclusive means mute /
-- unmute / toggle muting of all channels outside the specified range.
data MuteOperation = MuteInclusive | MuteExclusive
  deriving (Eq, Show)

-- | When loading a module Curious will cause the loader to attempt to load
-- hidden tracks past the end of the song.
data CuriousFlag = Curious | NotCurious
  deriving (Eq, Show)

data MDriver

data MDriverInfo = MDriverInfo
  { mdriverName :: String
  , mdriverHardVoiceLimit :: Int
  , mdriverSoftVoiceLimit :: Int
  , mdriverAlias :: String
  } deriving (Show)

data Module

-- | Handle to a Module object which contains the music data and current
-- playback state of a song.
type ModuleHandle = Ptr Module

-- | Static info about a module.
data ModuleInfo = ModuleInfo
  { moduleSongname       :: String
  , moduleModType        :: String
  , moduleComment        :: Maybe String
  , moduleFlags          :: [ModuleFlag]
  , moduleNumChannels    :: Int
  , moduleNumVoices      :: Int
  , moduleNumPositions   :: Int
  , moduleNumPatterns    :: Int
  , moduleNumInstruments :: Int
  , moduleNumSamples     :: Int
  , moduleInstruments    :: Maybe [String]
  } deriving (Show)

data Sample

type SampleHandle = Ptr Sample

-- | Static info about a sample.
data SampleInfo = SampleInfo
  { samplePanning :: Int
  , sampleSpeed :: Int
  , sampleVolume :: Int
  , sampleFlags :: [SampleFlag]
  , sampleInflags :: [SampleFlag]
  , sampleLength :: Int
  , sampleLoopStart :: Int
  , sampleLoopEnd :: Int
  } deriving (Show)

-- | Collection of IO operations that MikMod can use to load data from an
-- arbitrary source, such as a memory buffer or zip file.
data MReader = MReader
  { -- | Move the read position. Return 0 for success and -1 for failure.
    readerSeek :: Int -> SeekMode -> IO Int
    -- | Report the current read position.
  , readerTell :: IO Int
    -- | Write a number of bytes to the destination and advance the read position.
    -- Return True if an error occurred or False otherwise. EOF is not an error.
  , readerRead :: Ptr Word8 -> Int -> IO Bool
    -- | Return one byte and advance the read position. If an error occurs or
    -- we are at the end-of-stream, then return eof.
  , readerGet  :: IO Int
    -- | Return True if we are at the end of the stream. Otherwise return False.
  , readerEof  :: IO Bool }


data Instrument
