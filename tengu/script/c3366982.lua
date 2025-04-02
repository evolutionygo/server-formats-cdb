--ドラゴンに乗るワイバーン
--Alligator’s Sword Dragon
function c3366982.initial_effect(c)
	c:EnableReviveLimit()
	--Fusion Material
	aux.AddFusionProcCode2(c,true,true,88819587,64428736)
	--Can attack directly
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DIRECT_ATTACK)
	e2:SetCondition(c3366982.dircon)
	c:RegisterEffect(e2)
end
function c3366982.dircon(e)
	local ATTRIBUTE_EARTH_WATER_FIRE=ATTRIBUTE_EARTH|ATTRIBUTE_WATER|ATTRIBUTE_FIRE
	local g=Duel.GetMatchingGroup(Card.IsFaceup,e:GetHandlerPlayer(),0,LOCATION_MZONE,nil)
	local ct=#g
	return ct>0 and g:FilterCount(Card.IsAttribute,nil,ATTRIBUTE_EARTH_WATER_FIRE)==ct
end