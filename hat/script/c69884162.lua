--E・HERO アナザー・ネオス
--Elemental HERO Neos Alius
function c69884162.initial_effect(c)
	Gemini.AddProcedure(c)
	--Becomes "Elemental HERO Neos" while on the field
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(Gemini.EffectStatusCondition)
	e1:SetValue(CARD_NEOS)
	c:RegisterEffect(e1)
end
c69884162.listed_names={CARD_NEOS}