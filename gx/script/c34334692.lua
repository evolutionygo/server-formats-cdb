--儀式の供物
--Ritual Raven
function c34334692.initial_effect(c)
	--ritual level
	Ritual.AddWholeLevelTribute(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK))
end