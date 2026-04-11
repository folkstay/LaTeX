data Element = Fire | Ice | Lightning | Arcane
data HeroClass = Warrior | Mage | Healer | Rogue
data Rarity = Common | Rare | Legendary
data HeroStats = HeroStats HeroClass Rarity

type HeroName = String
type Title = String
type Level = Int 
type ClassName = String
type HeroIdentity = (HeroName, Title)

showHeroClass :: HeroClass -> String
showHeroClass Warrior = "Warrior"
showHeroClass Mage = "Mage"
showHeroClass Healer = "Healer"

showHeroRarity :: Rarity -> String
showHeroRarity Common = "Common"
showHeroRarity Rare = "Rare"
showHeroRarity Legendary = "Legendary"

showHeroStats :: HeroStats -> String 
showHeroStats (HeroStats cls rarity) =
  showHeroRarity rarity ++ showHeroClass cls 

elementSymbol :: Element -> Char
elementSymbol Fire = 'F'
elementSymbol Ice = 'I'
elementSymbol Lightning = 'L'
elementSymbol Arcane = 'A'

getHeroName :: HeroIdentity -> HeroName
getHeroName hero = fst hero

getHeroTitle :: HeroIdentity -> Title
getHeroTitle hero = snd hero

heroCard :: HeroName -> Title -> Level -> ClassName -> String
heroCard hname title lvl cls = hname ++ " " ++ title
  ++ " [" ++ show lvl ++ "] " ++ cls