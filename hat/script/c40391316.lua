--おジャマ・ナイト
function c40391316.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2N(c,true,true,aux.FilterBoolFunctionEx(Card.IsSetCard,0xf),2)
	--disable field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_DISABLE_FIELD)
	e2:SetOperation(c40391316.disop)
	c:RegisterEffect(e2)
end
c40391316.listed_series={0xf}
c40391316.material_setcode={0xf}
function c40391316.disop(e,tp)
	local c=Duel.GetLocationCount(1-tp,LOCATION_MZONE,PLAYER_NONE,0)
	if c==0 then return end
	local dis1=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,0)
	if c>1 and Duel.SelectYesNo(tp,aux.Stringc40391316(c40391316,0)) then
		local dis2=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,dis1)
		dis1=(dis1|dis2)
	end
	return dis1
end