data Element = Fire | Ice | Lighting | Arcane deriving (Eq, Ord)
data Rarity = Common | Rare | Legendary

instance Show Rarity where
  show Common = "* Usual"
  show Rare = "** Rare"
  show Legendary = "*** Legendary" 

instance Show Element where
  show Fire = "Fire"
  show Ice = "Ice"
  show Lighting = "Lighting"
  show Arcane = "Arcane"

newtype PowerLevel = PowerLevel Int deriving (Show, Eq)

instance Ord PowerLevel where
  compare (PowerLevel a) (PowerLevel b) = compare b a



