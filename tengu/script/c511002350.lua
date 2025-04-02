--E・HERO オーシャン
function c511002350.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c511002350.dircon)
	c:RegisterEffect(e1)
end
c511002350.listed_names={CARD_UMI}
function c511002350.dircon(e)
	return Duel.IsEnvironment(CARD_UMI)
end