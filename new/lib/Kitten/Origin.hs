module Kitten.Origin
  ( Origin(..)
  , begin
  , end
  , point
  , pos
  , range
  ) where

import Data.Text (Text)
import Text.Parsec.Pos
import qualified Data.Text as Text

data Origin = Origin
  { name :: !Text
  , beginLine :: !Line
  , beginColumn :: !Column
  , endLine :: !Line
  , endColumn :: !Column
  } deriving (Eq, Show)

begin :: Origin -> SourcePos
begin = newPos <$> Text.unpack . name <*> beginLine <*> beginColumn

end :: Origin -> SourcePos
end = newPos <$> Text.unpack . name <*> endLine <*> endColumn

point :: SourceName -> Line -> Column -> Origin
point path line column = Origin
  { name = Text.pack path
  , beginLine = line
  , beginColumn = column
  , endLine = line
  , endColumn = column
  }

pos :: SourcePos -> Origin
pos = point <$> sourceName <*> sourceLine <*> sourceColumn

range :: SourcePos -> SourcePos -> Origin
range a b = Origin
  { name = Text.pack $ sourceName a
  , beginLine = sourceLine a
  , beginColumn = sourceColumn a
  , endLine = sourceLine b
  , endColumn = sourceColumn b
  }
