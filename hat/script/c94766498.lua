--先史遺産アステカ・マスク・ゴーレム
--Chronomaly Aztec Mask Golem
function c94766498.initial_effect(c)
	c:SetUniqueOnField(1,0,c94766498)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c94766498.hspcon)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(c94766498,ACTIVITY_CHAIN,c94766498.chainfilter)
end
c94766498.listed_series={0x70}
function c94766498.chainfilter(re,tp,cc94766498)
	return not (re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsSetCard(0x70))
end
function c94766498.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetCustomActivityCount(c94766498,tp,ACTIVITY_CHAIN)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end